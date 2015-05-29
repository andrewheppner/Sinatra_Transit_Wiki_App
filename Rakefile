require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear
Rake::Task["db:seed"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Seeds users and pics'
task "db:seed" do 
  puts "Seeding..."

  User.destroy_all
  Pic.destroy_all
  
  user1 = User.create!(email: "email1@email1", username: "user1", password: "password1")
  user2 = User.create!(email: "email2@email2", username: "user2", password: "password2")
  city1 = City.create!(name: "Toronto")
  city2 = City.create!(name: "Paris")
  pic1 = user1.pics.create!(path: "http://lorempixel.com/400/200/", pic_title: "random1", city_id: city1)
  pic2 = user2.pics.create!(path: "http://www.viajarpelomundo.com.br/wp-content/uploads/Tamandua-mirim.jpg", pic_title: "andrews_fave", city_id: city2)
end
