class Reminder < ApplicationRecord
  enum category: [ :water, :light, :fertilizer ]

  belongs_to :user_plant

  validates :category, presence: true
  validates :start_date, presence: true

  after_update :async_update

  private

  def async_update
    # ReminderJob.set(wait_until: DateTime.parse((self.start_date.in_time_zone("Mexico City") + 8.hours).to_s)).perform_later(self)
    # Demo reminder
    if active
      ReminderJob.set(wait_until: DateTime.parse((DateTime.now + 10.seconds).to_s)).perform_later(self)
    end
  end
end
