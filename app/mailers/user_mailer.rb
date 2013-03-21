class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def project_invitation(inviter, invitee)
    @user = invitee
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{invitee.email}", :subject => "Batbugger: Project Invitation")
  end

end
