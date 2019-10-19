# frozen_string_literal: true

class ScoreSerializer < BaseSerializer
  set_type :score
  attributes :user_id,
             :music_id,
             :difficulty,
             :points,
             :max_combo,
             :critical_count,
             :correct_count,
             :nice_count,
             :miss_count,
             :played_times,
             :platform

  belongs_to :user
  belongs_to :music
end
