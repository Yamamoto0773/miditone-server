# frozen_string_literal: true

module Api
  class RankingController < BaseController
    before_action :set_music

    def index
      @scores = if given_difficulty_params?
                  @music.scores.where(difficulty: params[:difficulty]).order(points: :desc)
                else
                  @music.scores.order([points: :desc], :difficulty)
                end

      render json: ScoreSerializer.new(@scores, include: include_list)
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
