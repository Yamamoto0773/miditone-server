# frozen_string_literal: true

class User < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_one :preference, dependent: :destroy

  validates :qrcode,
    presence: true,
    uniqueness: true,
    format: { with: /\A\d*\z/ }, # numbers only
    length: { is: 12 }
  validates :name,
    presence: true,
    # only typeable characters by keyboard, except space and \n
    format: { with: %r{\A[\w`~!@#$%^&\*\(\)-=\+\[\]\{\}\\|;:'",<\.>\/\?]+\z} },
    length: { maximum: 10 }
end
