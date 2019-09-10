# frozen_string_literal: true

class Preference < ApplicationRecord
  belongs_to :user

  validates :note_speed,
    numericality: { grather_than_or_equal_to: 0.0 }
  validates :se_volume,
    numericality: { grather_than_or_equal_to: 0 }
  validates :user_id,
    uniqueness: true
end
