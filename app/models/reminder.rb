class Reminder < ApplicationRecord
  enum category: [ :water, :light, :fertilizer ]

  belongs_to :user_plant

  validates :category, presence: true
  validates :start_date, presence: true
end
