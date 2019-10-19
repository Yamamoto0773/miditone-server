# frozen_string_literal: true

module Api
  class PlayedTimesController < BaseController
    include ScoresGettable

    before_action :set_music, only: :of_music

    def of_all_musics
      played_times = {}
      Music.find_each do |music|
        played_times.store(
          music.id,
          get_platform_scores(parent: music).pluck(:played_times).sum
        )
      end

      render json: played_times
    end

    def of_music
      played_times = {}
      Score.difficulty.values.each do |difficulty|
        played_times.store(
          difficulty,
          get_platform_scores(parent: @music).where(difficulty: difficulty).pluck(:played_times).sum
        )
      end

      sum = played_times.values.reduce(:+)

      render json: played_times.merge(total: sum)
    end

    private

    def set_music
      @music = Music.find(params[:id])
    end
  end
end
