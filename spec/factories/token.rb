# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    name { 'test' }
    key { 'secure' }
  end
end
