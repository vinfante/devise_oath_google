class ReminderMailer < ApplicationMailer
  def reminder_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Reminder: Fill out your invoice')
  end
end
