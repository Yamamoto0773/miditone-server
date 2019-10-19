# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    difficulty { :easy }
    points { 600_000 }
    played_times { 1 }
    platform { :button }
  end
end
