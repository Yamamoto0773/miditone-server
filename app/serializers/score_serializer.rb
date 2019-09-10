# frozen_string_literal: true

class ScoreSerializer < BaseSerializer
  set_type :score
  attributes :user_id, :music_id, :difficulty, :points

  belongs_to :user
  belongs_to :music
end
