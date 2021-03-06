class NotesController < ApplicationController

  layout "project_task"
  
  def index
    @project = current_user.projects.find(params[:project_id])
    @story = @project.stories.find(params[:story_id])
    @notes = @story.notes
    render :json => @notes
  end

  def show
    @project = current_user.projects.find(params[:project_id])
    @story = @project.stories.find(params[:story_id])
    @note = @story.notes.find(params[:id])
    render :json => @note
  end

  def destroy
    @project = current_user.projects.find(params[:project_id])
    @story = @project.stories.find(params[:story_id])
    @note = @story.notes.find(params[:id])
    @note.destroy
    head :ok
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @story = @project.stories.find(params[:story_id])
    @note = @story.notes.build(params[:note])
    @note.user = current_user
    if @note.save
      render :json => @note
    else
      render :json => @note, :status => :unprocessable_entity
    end
  end
end
