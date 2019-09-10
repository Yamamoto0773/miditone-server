# frozen_string_literal: true

module Api
  class MusicsController < BaseController
    protect_from_forgery

    before_action :set_music, except: %i[index create]

    def index
      @music = Music.all
      render json: MusicSerializer.new(@music)
    end

    def show
      render json: MusicSerializer.new(@music)
    end

    def create
      @music = Music.new(music_params)

      if @music.save
        render json: MusicSerializer.new(@music), status: :created
      else
        render_validation_errors @music
      end
    end

    def update
      if @music.update(music_params)
        render json: MusicSerializer.new(@music)
      else
        render_validation_errors @music
      end
    end

    def destroy
      if @music.destroy
        head :no_content
      else
        render_validation_errors @music
      end
    end

    private

    def set_music
      @music = Music.find(params[:id])
    end

    def music_params
      params.require(:music).permit(:title, :artist)
    end
  end
end
