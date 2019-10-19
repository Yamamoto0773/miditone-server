# frozen_string_literal: true

module Api
  class RankingController < BaseController
    include ScoresGettable

    before_action :set_music

    def index
      scores = if given_difficulty_params?
                 get_platform_scores(parent: @music).where(difficulty: params[:difficulty])
               else
                 get_platform_scores(parent: @music)
               end

      scores = scores.order([points: :desc], :difficulty).includes(:user)

      render json: ScoreSerializer.new(scores, include: include_list)
    end

    private

    def set_music
      @music = Music.find(params[:music_id])
    end

    def given_difficulty_params?
      Score.difficulty.values.include?(params[:difficulty])
    end

    def include_list
      %i[music user]
    end
  end
end
