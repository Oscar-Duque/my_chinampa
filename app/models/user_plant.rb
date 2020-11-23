class UserPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  has_many :reminders, dependent: :destroy
  has_one_attached :photo

  validates :nickname, presence: true, uniqueness: { scope: :user }
end
