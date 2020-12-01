class AllremindersJob < ApplicationJob
  queue_as :default

  def perform
    # select all the reminders from today
    # selectionar todos
    reminders = Reminder.where(start_date: Date.today)
    reminders.each do |reminder|
      if reminder.category == "water"
        frequency = reminder.user_plant.plant.water_frequency
      elsif reminder.category == "light"
        frequency = reminder.user_plant.plant.light_frequency
      else
        frequency = reminder.user_plant.plant.fertilizer_frequency
      end
      ReminderJob.set(wait_until: DateTime.parse((DateTime.now + frequency.days).to_s)).perform_later(self)
      reminder.start_date = DateTime.now + frequency.days
      reminder.save
    end
    puts "As a I run at 8 everyday"
  end
end
