# frozen_string_literal: true

module Api
  class PlayedTimesController < BaseController
    include ScoresGettable

    before_action :set_music, only: :of_music

    def of_all_musics
      musics = paginate(Music.order(:id))

      render json: PlayedTimesSerializer.new(musics, params: { platform: platform })
    end

    def of_music
      render json: PlayedTimesSerializer.new(@music, params: { platform: platform })
    end

    private

    def set_music
      @music = Music.find(params[:id])
    end
  end
end
