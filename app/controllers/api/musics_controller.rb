# frozen_string_literal: true

module Api
  class MusicsController < BaseController
    protect_from_forgery

    before_action :set_music, except: %i[index create played_times_of_all_musics]

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

    def played_times_of_all_musics
      played_times = {}
      Music.find_each do |music|
        played_times.store( 
          music.id,
          music.scores.pluck(:played_times).sum
        )
      end

      render json: played_times
    end

    def played_times_of_a_music
      played_times = {}
      Score.difficulty.values.each do |difficulty|
        played_times.store(
          difficulty,
          Score.where(music_id: @music.id, difficulty: difficulty).pluck(:played_times).sum
        )
      end

      sum = played_times.values.reduce(:+)

      render json: played_times.merge(total: sum)
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
