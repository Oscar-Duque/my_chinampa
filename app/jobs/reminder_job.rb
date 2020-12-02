class ReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder)
    puts "I'm sending you a #{reminder.start_date}"
    # puts "Puts #{reminder.user_plant.user.email}"
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @reminder = Twilio::REST::Client.new(account_sid, auth_token)

      message = @reminder.messages.create(
          body: 'OSCAR. PONLE AGUA A TUS PLANTAS!',
          from: '+12513134466',
          to: '+525585735072'
          )
  end
end
