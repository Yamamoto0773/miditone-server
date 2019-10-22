# frozen_string_literal: true

class PlayedTimesSerializer < BaseSerializer
  set_type :played_times

  attributes :music_id, &:id
  attributes :times do |music, params|
    music.scores.with_platform(params[:platform]).pluck(:played_times).sum
  end
  attributes :platform do |_, params|
    params[:platform]
  end
end
