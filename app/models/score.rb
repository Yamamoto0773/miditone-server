# frozen_string_literal: true

class Score < ApplicationRecord
  include Platform

  belongs_to :user
  belongs_to :music

  validates :user_id, :music_id, :difficulty, :points, :max_combo,
    :critical_count, :correct_count, :nice_count, :miss_count, :played_times, :platform,
    presence: true
  validates :difficulty,
    uniqueness: { scope: %i[user_id music_id platform] }
  validates :points,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000 }
  validates :max_combo, :critical_count, :correct_count, :nice_count, :miss_count, :played_times,
    numericality: { greater_than_or_equal_to: 0 }

  enumerize :difficulty,
    in: { easy: '0', normal: '1', hard: '2' }
end
