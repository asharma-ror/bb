class ChangesetsController < ApplicationController

  layout "project_task"
  
  def index
    @project = current_user.projects.find(params[:project_id])
    # FIXME extract method to model
    scope = @project.changesets.scoped
    scope = scope.where('id <= ?', params[:to]) unless params[:to].blank?
    scope = scope.where('id > ?', params[:from]) unless params[:from].blank?
    @changesets = scope
    render :json => @changesets
  end
end
