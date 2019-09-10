# frozen_string_literal: true

class Score < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :music

  validates :user_id, :music_id, :difficulty, :points,
            presence: true
  validates :user_id,
            uniqueness: { scope: %i[music_id difficulty] }
  validates :points,
            numericality: { grather_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000 }

  enumerize :difficulty,
            in: { easy: '0', normal: '1', hard: '2' }
end
