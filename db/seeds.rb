# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  u = User.create(name: FFaker::Lorem.characters(10), qrcode: ApplicationHelper.random_number_str(12))
  u.preferences.create!(note_speed: rand(1..10) + rand(2) / 2.0, se_volume: rand(0..10), platform: :button)
  u.preferences.create!(note_speed: rand(1..10) + rand(2) / 2.0, se_volume: rand(0..10), platform: :board)
end
