class UserPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  has_many :reminders, dependent: :destroy
  has_one_attached :photo
  has_one :family, through: :plant

  validates :nickname, presence: true, uniqueness: { scope: :user }
  # validates :photo, presence: true

  after_create :create_reminders

  def create_reminders
    # reminder_water
    Reminder.create!(category: "water", start_date: Date.today, user_plant: self)
    # reminder_light
    Reminder.create!(category: "light", start_date: Date.today, user_plant: self)
    # reminder_fertilizer
    Reminder.create!(category: "fertilizer", start_date: Date.today, user_plant: self)
  end
end
