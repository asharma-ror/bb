class ErrorsController < ApplicationController

  
  layout "auction"
  
  before_filter :check_project_subscription, :only=> [:exceptions]
  before_filter :store_location, :only => [:exceptions, :resolved, :all_exceptions]
  before_filter :authenticate_user!

  def exceptions
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors.active
  end
  
  def tracker
    project = current_user.projects.first
    if project
      redirect_to project
    else
      redirect_to new_project_path
    end
  end

  # get method
  def resolved
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors.resolved
    render action:"exceptions"
  end

  def all_exceptions
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors
    render action:"exceptions"
  end

  def update_resolved
    project = current_user.projects.find(params[:project_id])
    error = project.project_errors.active.find(params[:error_id])
    error.status = :resolved
    error.save
    redirect_to exception_path, :notice => "Exception was successfully resolved!"
  end

  def update_unresolved
    project = current_user.projects.find(params[:project_id])
    error = project.project_errors.resolved.find(params[:error_id])
    error.status = :active
    error.save
    redirect_to resolved_path, :notice => "Exception was re-opened!"
  end

  def error_trace
    @project = current_user.projects.find(params[:project_id])
    @error_trace = @project.project_errors.where(:id=>params[:error_id]).first.error_trace
    @location = Geokit::Geocoders::IpGeocoder.geocode(@error_trace.remote_ip)
  end

  def delete_permanently
    project = current_user.projects.find(params[:project_id])
    project_errors = project.project_errors.where("id IN (?)", params[:error_ids].split(",").map { |s| s.to_i })
    project_errors.map(&:destroy)
    redirect_back_or_default(exception_path) and return
  end

end
