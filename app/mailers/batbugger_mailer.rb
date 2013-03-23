class BatbuggerMailer < ActionMailer::Base
  default from: "no-reply@grepruby.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.batbugger_mailer.exception.subject
  #
  def exception(project,error)
    @error = error
    @project = project
    project.user_projects.each do |user_project|
      mail to: user_project.user.email, subject: "Exception Notification : #{project.name}"
    end
  end
end
