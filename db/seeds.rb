# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'spec_helper'

STATE_NAMES = [
  "Yellowhammer State",
  "The Last Frontier",
  "The Grand Canyon State",
  "The Natural State",
  "The Golden State",
  "The Centennial State",
  "The Constitution State",
  "The First State",
  "The Sunshine State",
  "The Peach State",
  "The Aloha State",
  "Gem State",
  "Prairie State",
  "The Hoosier State",
  "The Hawkeye State",
  "The Sunflower State",
  "The Bluegrass State",
  "The Pelican State",
  "Pine Tree State",
  "The Old Line State",
  "The Bay State",
  "The Great Lakes State",
  "The North Star State",
  "The Magnolia State",
  "The Show Me State",
  "The Treasure State",
  "The Cornhusker State",
  "The Silver State",
  "The Granite State",
  "The Garden State",
  "The Land of Enchantment",
  "The Empire State",
  "The Tar Heel State",
  "The Peace Garden State",
  "The Buckeye State",
  "The Sooner State",
  "Beaver State",
  "The Keystone State",
  "The Ocean State",
  "The Palmetto State",
  "Mount Rushmore State",
  "The Volunteer State",
  "Lone Star State",
  "The Beehive State",
  "The Green Mountain State",
]

games = []
games << Factory(:game, :nickname => "Australia")
games << Factory(:game, :nickname => "United States")
games << Factory(:game, :nickname => "Pangea")

users = []
users << Factory(:user)
users << Factory(:user)
users << Factory(:user)

srand
games.each_with_index do |game, i|
  users.each_with_index do |user, j|
    state = Factory(:state, :game => game, :user => user,
        :name => STATE_NAMES[(i + 1) * j])
    state.cities.each do |city|
      Factory(:generator, :city => state.cities.first,
          :generator_type => GeneratorType.find(
            rand(GeneratorType.all.count) + 1))
    end
  end
end
