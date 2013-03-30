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
        error_trace = error.create_error_trace(:application => application_error,
          :full => params["error"]["backtrace"],
          :source_code => params["error"]["source"],
          :url => params["request"]["url"],
          :params => params["request"]["params"],
          :action => params["request"]["action"],
          :environment => params["request"]["cgi_data"],
          :browser => params["request"]["cgi_data"]["HTTP_USER_AGENT"],
          :remote_ip => params["request"]["cgi_data"]["REMOTE_ADDR"])
        if project.pivotal_token
          PivotalTracker::Client.token = project.pivotal_token
          name = "New Exception : " + project.name + " : " + error.title
          desc = "--------------------- \n URL: \n --------------------- \n" + error_trace.url.to_s + "\n --------------------- \n Browser: \n --------------------- \n" + error_trace.browser.to_s + "\n --------------------- \n View Source: \n --------------------- \n" + error_trace.source_code.to_s + "\n --------------------- \n Parameters \n --------------------- \n" + error_trace.params.to_s + "\n --------------------- \n Enviornment \n --------------------- \n" + error_trace.environment.to_s + "\n --------------------- \n Context \n --------------------- \n" + error_trace.context.to_s
          @pivotal_project = PivotalTracker::Project.find(project.pivotal_project_id)
          @pivotal_project.stories.create(:name => name, :story_type => 'bug', :description => desc)
        end
        if project.campfire_token
          campfire = Tinder::Campfire.new(project.campfire_subdomain, :token => project.campfire_token)
          desc = "New Exception : " + project.name + " : " + error.title
          campfire.find_room_by_name(project.campfire_room).speak(desc)
        end
      else
        error = error_trace.error
        error.count = error.count + 1
        error.generated_at = Time.now
        error.save
      end
      project.user_projects.each do |user_project|
        BatbuggerMailer.exception(user_project,error).deliver  if user_project.status
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
