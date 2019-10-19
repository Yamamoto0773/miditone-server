# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    difficulty { :easy }
    points { 600_000 }
    max_combo { 200 }
    critical_count { 350 }
    correct_count { 120 }
    nice_count { 10 }
    miss_count { 20 }
    played_times { 1 }
    platform { :button }
  end
end
