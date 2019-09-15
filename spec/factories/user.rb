# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    qrcode { ApplicationHelper.random_number_str(12) }
    name { SecureRandom.alphanumeric(6) }

    after(:create) do |user|
      user.build_preference.save!
    end
  end
end
