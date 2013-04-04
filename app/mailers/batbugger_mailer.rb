class BatbuggerMailer < ActionMailer::Base
  default from: "no-reply@grepruby.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.batbugger_mailer.exception.subject
  #
  def exception(user_project, error)
    @error = error
    @project = user_project.project
    mail to: user_project.user.email, subject: "BatBugger (#{@project.name} : #{error.title})"
  end
end
