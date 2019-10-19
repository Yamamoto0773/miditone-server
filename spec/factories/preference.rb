# frozen_string_literal: true

FactoryBot.define do
  factory :preference do
    note_speed { rand(1..9) + rand(2) / 2.0 }
    se_volume { rand(1..9) }
    platform { :button }
  end
end
