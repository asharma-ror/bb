class UserMailer < ActionMailer::Base
  default from: "support@batbugger.com"

  def project_invitation(inviter, invitee, project)
    @user = invitee
    @invited_by = inviter
    @project = project
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail :to => "#{invitee.email}", :subject => "Batbugger: Project Invitation"
  end

end
