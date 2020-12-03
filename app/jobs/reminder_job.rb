class ReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder)
    puts "I'm sending you a #{reminder.start_date}"
    # puts "Puts #{reminder.user_plant.user.email}"
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @reminder = Twilio::REST::Client.new(account_sid, auth_token)

      message = @reminder.messages.create(
          #{reminder.user_plant.user.email}
          body: "CHRIS, NO OLVIDES PONER #{reminder.category.upcase} A TU PLANTA MARGARITAS!",
          from: '+12568263283',
          # for the real ap
          # to: "#{reminder.user_plant.user.phone_number}"
          # for the Demo
          to: '+525568030362'
          )
  end
end
