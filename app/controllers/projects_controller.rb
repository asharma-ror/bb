class ProjectsController < ApplicationController

  layout "auction"
  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.active_projects.includes(:project_errors)
    @project_invitations = current_user.user_projects.pending

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = current_user.active_projects.find(params[:id])
    if @project.pivotal_token
      PivotalTracker::Client.token = @project.pivotal_token
      @pivotal_projects = PivotalTracker::Project.all
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.active_projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        @project.user_projects.create(:user_id => current_user.id, :status => true)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = current_user.active_projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = current_user.active_projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end


  def invitation
    project = current_user.active_projects.find(params[:id])
    user = User.where(:email => params[:invitation][:email]).first
    if user.present?
       if user.encrypted_password.blank?
         user = User.invite!({:email => params[:invitation][:email]}, current_user)
       else
         unless user.user_projects.map(&:project).include?(project)
           UserMailer.project_invitation(current_user, user).deliver
         else
           @notice = "User has already assined this project"
         end
       end
    else
      user = User.invite!({:email => params[:invitation][:email]}, current_user)
    end
    unless user.user_projects.map(&:project).include?(project)
      UserProject.create(:user_id => user.id,
        :project_id => project.id,
        :status => false
      )
    end
  end

  def accept
    userproject = current_user.user_projects.where(:project_id => params[:id]).first
    userproject.status = true
    if userproject.save
      redirect_to projects_path, :notice => "Thanks, Project has been added in your list"
    else
      redirect_to projects_path, :notice => "Something went wrong!"
    end
  end

  def decline
    userproject = current_user.user_projects.where(:project_id => params[:id]).first
    userproject.destroy
    redirect_to projects_path, :notice => "NOTICE: You have declined invitation!"
  end

  def pivotal_authenticate
    @project = current_user.active_projects.find(params[:id])
    pivotal_token = PivotalTracker::Client.token(params[:authenticate][:email], params[:authenticate][:password]) rescue nil
    if pivotal_token.blank?
      @notice = "Invalid authentication details"
    else
      @project.update_attributes(:pivotal_token => pivotal_token)
      @pivotal_projects = PivotalTracker::Project.all
    end
  end

  def pivotal
    if params[:pivotal_project_id]
      @project = current_user.active_projects.find(params[:id])
      project_name = PivotalTracker::Project.find(params[:pivotal_project_id].to_i)
      @project.update_attributes(:pivotal_project_id => params[:pivotal_project_id], :pivotal_project_name => project_name.name)
    else
      @notice = "Something went wrong please try again later."
    end

  end

end
