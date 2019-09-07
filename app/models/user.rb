# frozen_string_literal: true

class User < ApplicationRecord
  validates :qrcode,
            presence: true,
            uniqueness: true,
            format: /\A\d*\z/, # numbers only
            length: { is: 12 }
  validates :name,
            presence: true,
            length: { maximum: 10 }
end
