class ExceptionsController < ApplicationController

  def exception
    project = Project.find_by_key(request.headers["X-API-Key"])
    application_error = params["error"]["backtrace"].select{|per| per["file"].include?("PROJECT_ROOT")}
    source_error = params["error"]["source"]
    unless project.nil?
      error_trace  = project.error_trace.select{|error_trace| error_trace.source_code == source_error}.first
      if error_trace.blank?
        error = project.project_errors.create(:count=> 1,
          :desc => params["error"]["message"],
          :status => :active,
          :title => params["error"]["class"] + " in " + params["request"]["component"] + " # " + params["request"]["action"] +" in " + params["server"]["environment_name"],
          :url => params["request"]["url"],
          :generated_at => Time.now
        )
        error.create_error_trace(:application => application_error,
          :full => params["error"]["backtrace"],
          :source_code => params["error"]["source"],
          :url => params["request"]["url"],
          :params => params["request"]["params"],
          :action => params["request"]["action"],
          :environment => params["request"]["cgi_data"],
          :browser => params["request"]["cgi_data"]["HTTP_USER_AGENT"],
          :remote_ip => params["request"]["cgi_data"]["REMOTE_ADDR"])
      else
        error = error_trace.error
        error.count = error.count + 1
        error.generated_at = Time.now
        error.save
      end
      BatbuggerMailer.exception(project,error).deliver
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
