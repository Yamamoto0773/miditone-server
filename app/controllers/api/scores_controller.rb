# frozen_string_literal: true

module Api
  class ScoresController < BaseController
    protect_from_forgery

    before_action :set_user, only: %i[index create]
    before_action :set_score, except: %i[index create]

    def index
      @scores = if given_difficulty_params?
                  @user.scores.where(difficulty: params[:difficulty]).order(:music_id, :difficulty)
                else
                  @user.scores.order(:music_id, :difficulty)
                end

      render json: ::Api::ScoreSerializer.new(@scores, include: include_list)
    end

    def show
      render json: ::Api::ScoreSerializer.new(@score, include: include_list)
    end

    def create
      @score = @user.scores.build(score_params)

      if @score.save
        render json: ::Api::ScoreSerializer.new(@score, include: include_list), status: :created
      else
        render_validation_errors @score
      end
    end

    def update
      if @score.update(score_params)
        render json: ::Api::ScoreSerializer.new(@score, include: include_list)
      else
        render_validation_errors @score
      end
    end

    def destroy
      if @score.destroy
        head :no_content
      else
        render_validation_errors @score
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_score
      @score = Score.find(params[:id])
    end

    def score_params
      params.require(:score).permit(:music_id, :difficulty, :points)
    end

    def given_difficulty_params?
      Score.difficulty.values.include?(params[:difficulty])
    end

    def include_list
      %i[music]
    end
  end
end
