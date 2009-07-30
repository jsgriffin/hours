class MailSystem < ActionMailer::Base
  def mail(user, message)
    recipients	"jsgriffin@imaginaryroots.co.uk"
    subject		"Feedback for hours"
    body		(:user=>user, :message=>message)
  end
  
  def new_user(user)
  	recipients	"jsgriffin@imaginaryroots.co.uk"
  	subject		"Hours: new user"
  	body		(:user=>user)
  end
end
