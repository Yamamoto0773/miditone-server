# frozen_string_literal: true

class User < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_many :preferences, dependent: :destroy

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
  validates :button_total_score, :board_total_score,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }
end
