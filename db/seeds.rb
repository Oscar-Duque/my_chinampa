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
  file = URI.open("https://trefle.io/api/v1/plants?token=H9S4whTeEyH0ygR9DTNivOfwjLSmy3TmeV_nU5GdJjQ&filter_not[common_name]=null&page=#{page}")
  plant_serialized = file.read
  new_plant = JSON.parse(plant_serialized)

  new_plant['data'].each do |plant|
    # skips if family is nill
    next if ( plant["family_common_name"].nil? && plant["family"].nil? )
    # skips if common_name is nill
    next if plant["common_name"].nil?
    # skips if no image_url
    next if plant["image_url"].nil?

    # Check for family or create it
    family_name = plant["family_common_name"] || plant["family"]
    family = Family.find_by(name: family_name)
    family = Family.create!(name: family_name) unless family

    plant_name = plant["common_name"]
    plant_photo = plant["image_url"]

    # plant description from Wikipedia
    wikisearchfile = URI.open("https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=#{plant_name}&format=json")
    wikisearch = wikisearchfile.read
    wikisearchresult = JSON.parse(wikisearch)
    # skips if no results on wikipedia
    next if wikisearchresult['query']['searchinfo']['totalhits'] == 0
    p "wiki found"
    # get first wikipedia page from the wikisearch
    wikititle = wikisearchresult['query']['search'][0]['title']
    wikipedia_link = "https://en.wikipedia.org/wiki/#{wikititle}"
    # HTML pased version:
    # wikiarticlefile = URI.open("https://en.wikipedia.org/w/api.php?action=parse&page=#{wikititle}&prop=text&format=json")
    # original wikitext version:
    # wikiarticlefile = URI.open("https://en.wikipedia.org/w/api.php?action=parse&page=#{wikititle}&prop=wikitext&format=json")
    # wiki TextExtracts version:
    wikiarticlefile = URI.open("https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exintro=true&exlimit=1&titles=#{wikititle}&explaintext=1&format=json")
    wikiarticle = wikiarticlefile.read
    wikiarticlecontent = JSON.parse(wikiarticle)
    plant_description = wikiarticlecontent['query']['pages'].values[0]['extract']

    water = (1..15).to_a.sample
    light = (1..5).to_a.sample
    fertilizer = (3..6).to_a.sample
    Plant.create!(name: plant_name, api_photo: plant_photo, family: family, description: plant_description, wikipedia_link: wikipedia_link, water_frequency: water, light_frequency: light, fertilizer_frequency: fertilizer)
    print "."
  end
  puts "Done with page #{page}"
  page += 1
  # sleep 0.5
end
puts "Done folks!"

## Creating some users
puts 'Creating some Users...'

# CREATING CHRIS
user1 = User.create!(email: 'chris@gmail.com', first_name: 'Christian', password: '123456', password_confirmation: '123456')
file = URI.open('https://images.unsplash.com/photo-1539605480396-a61f99da1041?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
user1.photo.attach(io: file, filename: 'user1.jpeg', content_type: 'image/jpeg')


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
file = URI.open('https://images.unsplash.com/photo-1539605480396-a61f99da1041?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
user2.photo.attach(io: file, filename: 'user2.jpeg', content_type: 'image/jpeg')

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
file = URI.open('https://images.unsplash.com/photo-1539605480396-a61f99da1041?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
user3.photo.attach(io: file, filename: 'user3.jpeg', content_type: 'image/jpeg')


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
file = URI.open('https://images.unsplash.com/photo-1539605480396-a61f99da1041?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
user4.photo.attach(io: file, filename: 'user4.jpeg', content_type: 'image/jpeg')

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

# user 5
user5 = User.create!(email: 'derek@gmail.com', first_name: 'Derek', password: '123456', password_confirmation: '123456')
file = URI.open('https://images.unsplash.com/photo-1539605480396-a61f99da1041?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
user5.photo.attach(io: file, filename: 'user5.jpeg', content_type: 'image/jpeg')

  user_plant13 = UserPlant.new(nickname: 'Andre', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1585016326448-428671b934ab?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjJ8fGludGVyaW9yJTIwcGxhbnR8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant13.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant13.save!

  user_plant14 = UserPlant.new(nickname: 'Porfirio', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1518012312832-96aea3c91144?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTd8fGludGVyaW9yJTIwcGxhbnR8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant14.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant14.save!

  user_plant15 = UserPlant.new(nickname: 'Jean-Michel', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1493957988430-a5f2e15f39a3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGludGVyaW9yJTIwcGxhbnR8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant15.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant15.save!

  user_plant16 = UserPlant.new(nickname: 'Pablo', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1485902409384-e367af5b5c92?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Njl8fHBsYW50fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant16.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant16.save!

  user_plant17 = UserPlant.new(nickname: 'Nicolas', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1516048015710-7a3b4c86be43?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTZ8fHBsYW50fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant17.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant17.save!

  user_plant18 = UserPlant.new(nickname: 'Charles-Edouard', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1510505751526-76254482fd38?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTN8fHBsYW50fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant18.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant18.save!

  user_plant19 = UserPlant.new(nickname: 'Jerome', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1494058303350-0bd5a9ecc5d3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDZ8fHBsYW50fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60')
  user_plant19.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant19.save!

  user_plant20 = UserPlant.new(nickname: 'Jacques', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1521503862198-2ae9a997bbc9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80')
  user_plant20.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant20.save!

  user_plant21 = UserPlant.new(nickname: 'Ernesto', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1453904300235-0f2f60b15b5d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjN8fHBsYW50fGVufDB8fDB8&auto=format&fit=crop&w=800&q=60')
  user_plant21.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant21.save!

  user_plant22 = UserPlant.new(nickname: 'Micheline', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1009&q=80')
  user_plant22.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant22.save!

  user_plant23 = UserPlant.new(nickname: 'Jeanne', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1518621327167-ea94ffba2a70?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1650&q=80')
  user_plant23.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant23.save!

  user_plant24 = UserPlant.new(nickname: 'Huguette', plant_id: Plant.all.sample.id, user_id: user5.id)
  file = URI.open('https://images.unsplash.com/photo-1503153181849-4e4f85a341ce?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=582&q=80')
  user_plant24.photo.attach(io: file, filename: 'box.jpeg', content_type: 'image.jpeg')
  p user_plant24.save!




puts 'You have 5 user now with 3 plants each, plus 12 plants for the last user!'


