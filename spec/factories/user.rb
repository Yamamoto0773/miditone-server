# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    qrcode { ApplicationHelper.random_number_str(12) }
    name { SecureRandom.alphanumeric(6) }

    after(:create) do |user|
      user.preferences.create!(platform: :button)
      user.preferences.create!(platform: :balance_board)
    end
  end
end
