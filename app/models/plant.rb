class Plant < ApplicationRecord
  belongs_to :family

  has_many :user_plants

  validates :name, presence: true
  validates :description, presence: true

end
