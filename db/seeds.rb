# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Users
3.times do |i|
  qrcode = i.to_s.rjust(12, '0')
  u = User.create!(name: "dev#{i}", qrcode: qrcode)
  u.preferences.create!(note_speed: 10.0, se_volume: 5, platform: :button)
  u.preferences.create!(note_speed: 10.0, se_volume: 5, platform: :board)
end

# Musics
csv_path = Rails.root.join('musics.csv')
CSV.foreach(csv_path) do |row|
  next unless row[1] =~ /\A\d+\z/

  id = row[1].to_i
  title = row[2]
  artist = row[3]

  next if title.blank?

  Music.create!(id: id, title: title, artist: artist)
end

# Scores
Score.create!(
  user:           User.first,
  music:          Music.first,
  difficulty:     :normal,
  points:         800_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button
)
Score.create!(
  user:           User.second,
  music:          Music.first,
  difficulty:     :normal,
  points:         900_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button,
)
Score.create!(
  user:           User.third,
  music:          Music.first,
  difficulty:     :normal,
  points:         950_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button,
)
Score.create!(
  user:           User.first,
  music:          Music.second,
  difficulty:     :normal,
  points:         800_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button,
)
Score.create!(
  user:           User.second,
  music:          Music.second,
  difficulty:     :normal,
  points:         900_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button,
)
Score.create!(
  user:           User.third,
  music:          Music.second,
  difficulty:     :normal,
  points:         950_000,
  max_combo:      50,
  critical_count: 100,
  correct_count:  30,
  nice_count:     10,
  miss_count:     2,
  played_times:   1,
  platform:       :button,
)
