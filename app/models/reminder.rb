class Reminder < ApplicationRecord
  # enum type: [ :water, :light, :fertilizer ]

  belongs_to :user_plant

  validates :title, presence: true
  validates :start_date, presence: true
end
