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

  City.destroy_all
  User.destroy_all
  Pic.destroy_all
  
  user1 = User.create!(email: "email1@email1", username: "user1", password: "password1")
  user2 = User.create!(email: "email2@email2", username: "user2", password: "password2")
  city1 = City.create!(name: "Toronto", state:"Ontario", country:"Canada")
  city2 = City.create!(name: "Paris", country:"France")
  city1.pics.create(title: "Our Patron Saint", path:"http://images.wisegeek.com/sloth-in-tree-showing-claws.jpg")
  city1.transit_modes.create(
    name: "Subway",
    icon: "mdi-content-send",
    fare: "<p><strong>Fare Types:</strong><br>Tokens, Child/Senior Tickets, Daily, Weekly and Monthly passes (Monthly passes are called Metropasses)</p>\n    <p><strong>Where to buy:</strong><br>There are tellers and automated machines for purchasing Tokens at all stations, and machines for purchasing monthly passes at some stations.</p>\n    <p><strong>Using fares:</strong><br>To enter the subway, you must provide your fare to a teller, or if you are using a monthly pass or token, you can insert them directly into turnstiles</p>\n",
    transfers:"<p><strong>Obtaining a transfer:</strong><br>Tokens, Child/Senior Tickets, Daily, Weekly and Monthly passes (Monthly passes are called Metropasses)</p>\n    <p><strong>When to transfer:</strong><br>There are tellers and automated machines for purchasing Tokens at all stations, and machines for purchasing monthly passes at some stations.</p>\n    <p><strong>What transfers let you do:</strong><br>Buses and Streetcars</p>\n    <p><strong>Time limits:</strong><br>1 hour and 30 minutes, with no stop in between.</p>\n")
end
