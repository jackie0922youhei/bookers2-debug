class ThanksMailer < ApplicationMailer
  
  def send_when_signup(user)
    @user = user
    mail to: @user.email, subject: '【Bookers】 Thank you for your signing up!'
  end
  
end
