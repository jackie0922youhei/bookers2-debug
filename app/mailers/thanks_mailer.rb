class ThanksMailer < ApplicationMailer
  
  def send_when_signup(user, thanks)
    @user = user
    @thanks = thanks.signup
    mail to: user.email, subject: '【Bookers】 Thank you for your signing up!'
  end
  
end
