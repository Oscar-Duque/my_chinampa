class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_plants
  has_many :reminders, through: :user_plants
  has_many :plants, through: :user_plants

  # validates_length_of :password, :minimum => 6, :message => "You need to have at least a 6 characters password"
  validates :photo, presence: true

  has_one_attached :photo
end
