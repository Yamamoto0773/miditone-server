# frozen_string_literal: true

class User < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_one :preference, dependent: :destroy

  validates :qrcode,
    presence: true,
    uniqueness: true,
    format: /\A\d*\z/, # numbers only
    length: { is: 12 }
  validates :name,
    presence: true,
    length: { maximum: 10 }
end
