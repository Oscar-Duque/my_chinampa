# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

Plant.destroy_all
User.destroy_all

puts 'Creating some Plants...'
page = 1


while page <= 3
  file = URI.open("https://trefle.io/api/v1/plants?token=H9S4whTeEyH0ygR9DTNivOfwjLSmy3TmeV_nU5GdJjQ&page=#{page}")
  plant_serialized = file.read
  new_plant = JSON.parse(plant_serialized)

  new_plant['data'].each do |plant|
    # Check for family or create it
    family_name = plant["family_common_name"] || plant["family"]
    family = Family.find_by(name: family_name)
    family = Family.create!(name: family_name) unless family

    plant_name = plant["common_name"]
    # plant_description = plant["..."]
    plant_photo = plant["image_url"]
    water = (1..15).to_a.sample
    light = (1..5).to_a.sample
    fertilizer = (3..6).to_a.sample

    Plant.create!(name: plant_name, api_photo: plant_photo, family: family, water_frequency: water, light_frequency: light, fertilizer_frequency: fertilizer)
  end
  page += 1
end
puts "Done folks!"

## Creating some users
puts 'Creating some User...'

user1 = User.create!(email: 'chris@gmail.com', first_name: 'Christian', password: '123456', password_confirmation: '123456')

user2 = User.create!(email: 'agathe@gmail.com', first_name: 'Agathe', password: '123456', password_confirmation: '123456')

user3 = User.create!(email: 'corentin@gmail.com', first_name: 'Corentin', password: '123456', password_confirmation: '123456')

user4 = User.create!(email: 'oscar@gmail.com', first_name: 'Oscar', password: '123456', password_confirmation: '123456')


puts 'You have 4 user now!'


