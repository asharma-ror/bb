class ErrorsController < ApplicationController
  
  layout "auction"
  
  def exceptions
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors
  end
  
  def resolved
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors
  end
  
  def unresolved
    @project = current_user.projects.find(params[:project_id])
    @exceptions = @project.project_errors
  end
  
  def error_trace
    @project = current_user.projects.find(params[:project_id])
    @error_trace = @project.project_errors.where(:id=>params[:error_id]).first.error_trace
  end
  
end
