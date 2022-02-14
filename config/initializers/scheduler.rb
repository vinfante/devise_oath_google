require 'rufus-scheduler'
scheduler = Rufus::Scheduler.singleton

scheduler.cron '5 0 * * *' do
  User.find_each do |user|
    ReminderMailer.with(user: user).reminder_email.deliver_now
  end
end
