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

# CREATING CHRIS
user1 = User.create!(email: 'chris@gmail.com', first_name: 'Christian', password: '123456', password_confirmation: '123456')
  ## Creating some plants for the Chris
  user_plant1 = UserPlant.new(nickname: 'Renée', plant_id: Plant.all.sample.id, user_id: user1.id)
  file = URI.open('https://images.unsplash.com/photo-1463154545680-d59320fd685d?ixlib=rb-1.2.1&auto=format&fit=crop&w=646&q=80')
  user_plant1.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  p user_plant1.save!

  user_plant2 = UserPlant.new(nickname: 'Jacques', plant_id: Plant.all.sample.id, user_id: user1.id)
  file = URI.open('https://images.unsplash.com/photo-1512428813834-c702c7702b78?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80')
  user_plant2.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant2.save!

  user_plant3 = UserPlant.new(nickname: 'Charles-édouard', plant_id: Plant.all.sample.id, user_id: user1.id)
  file = URI.open('https://images.unsplash.com/photo-1485955900006-10f4d324d411?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1652&q=80')
  user_plant3.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant3.save!

# CREATING AGATHE
user2 = User.create!(email: 'agathe@gmail.com', first_name: 'Agathe', password: '123456', password_confirmation: '123456')
  ## Creating some plants for the Agathe
  user_plant4 = UserPlant.new(nickname: 'Jean-Charles', plant_id: Plant.all.sample.id, user_id: user2.id)
  file = URI.open('https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=818&q=80')
  user_plant4.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  p user_plant4.save!

  user_plant5 = UserPlant.new(nickname: 'Athos', plant_id: Plant.all.sample.id, user_id: user2.id)
  file = URI.open('https://images.unsplash.com/photo-1520412099551-62b6bafeb5bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80')
  user_plant5.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant5.save!

  user_plant6 = UserPlant.new(nickname: 'Gabrielle', plant_id: Plant.all.sample.id, user_id: user2.id)
  file = URI.open('https://images.unsplash.com/photo-1525946549228-596740434648?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80')
  user_plant6.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant6.save!


user3 = User.create!(email: 'corentin@gmail.com', first_name: 'Corentin', password: '123456', password_confirmation: '123456')
  user_plant7 = UserPlant.new(nickname: 'Bernadette', plant_id: Plant.all.sample.id, user_id: user3.id)
  file = URI.open('https://images.unsplash.com/photo-1517191434949-5e90cd67d2b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80')
  user_plant7.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  p user_plant7.save!

  user_plant8 = UserPlant.new(nickname: 'Biscuit', plant_id: Plant.all.sample.id, user_id: user3.id)
  file = URI.open('https://images.unsplash.com/photo-1521503862198-2ae9a997bbc9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80')
  user_plant8.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant8.save!

  user_plant9 = UserPlant.new(nickname: 'Patricia', plant_id: Plant.all.sample.id, user_id: user3.id)
  file = URI.open('https://images.unsplash.com/photo-1531517765038-ee4843469fd2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1658&q=80')
  user_plant9.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant9.save!


user4 = User.create!(email: 'oscar@gmail.com', first_name: 'Oscar', password: '123456', password_confirmation: '123456')
  user_plant10 = UserPlant.new(nickname: 'Josette', plant_id: Plant.all.sample.id, user_id: user4.id)
  file = URI.open('https://images.unsplash.com/photo-1453904300235-0f2f60b15b5d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80')
  user_plant10.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  p user_plant10.save!

  user_plant11 = UserPlant.new(nickname: 'Gertrude', plant_id: Plant.all.sample.id, user_id: user4.id)
  file = URI.open('https://images.unsplash.com/photo-1531797611996-666aa1f3df08?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80')
  user_plant11.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant11.save!

  user_plant12 = UserPlant.new(nickname: 'Marie-Noël', plant_id: Plant.all.sample.id, user_id: user4.id)
  file = URI.open('https://images.unsplash.com/photo-1526403297406-e6b1810cbd41?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80')
  user_plant12.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image/jpeg')
  user_plant12.save!



puts 'You have 4 user now with 3 plants each!'


