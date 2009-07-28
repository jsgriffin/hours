class MailSystem < ActionMailer::Base
  def mail(user)
    recipients	"jsgriffin@imaginaryroots.co.uk"
    subject		"Feedback for hours"
    body		(:user=>user)
  end
end
