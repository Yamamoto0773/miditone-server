# frozen_string_literal: true

class Preference < ApplicationRecord
  include Platform

  belongs_to :user

  validates :note_speed,
    numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validates :se_volume,
    numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :platform,
    presence: true, uniqueness: { scope: :user_id }
end
