class ExceptionsController < ApplicationController

  def exception
    project = Project.find_by_key(request.headers["X-API-Key"])
    application_error = params["error"]["backtrace"].select{|per| per["file"].include?("PROJECT_ROOT")}
    unless project.nil?
      error_trace  = project.error_trace.select{|error_trace| error_trace.application == application_error}.first
      if error_trace.blank?
        error = project.project_errors.create(:count=> 1,
          :desc => params["error"]["message"],
          :status => :active, 
          :title => params["error"]["class"] + " in " + params["controller"] + " # " + params["action"] +" in " + params["server"]["environment_name"], 
          :url => params["request"]["url"]
        )
        error.create_error_trace(:application => application_error, 
          :full => params["error"]["backtrace"])
      else
        error = error_trace.error
        error.count = error.count + 1
        error.save
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
  
end
