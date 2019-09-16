# frozen_string_literal: true

module Api
  class ScoresController < BaseController
    before_action :set_user, only: %i[index create]
    before_action :set_score, except: %i[index create]

    def index
      @scores = if given_difficulty_params?
                  @user.scores.where(difficulty: params[:difficulty]).order(:music_id)
                else
                  @user.scores.order(:music_id, :difficulty)
                end

      render json: ScoreSerializer.new(@scores, include: include_list)
    end

    def show
      render json: ScoreSerializer.new(@score, include: include_list)
    end

    def create
      @score = @user.scores.build(score_params.merge(played_times: 1))

      if @score.save
        render json: ScoreSerializer.new(@score, include: include_list), status: :created
      else
        render_validation_errors @score
      end
    end

    def update
      @score.points = params[:score][:points] if params[:score]&.key?(:points) && params[:score][:points].to_i > @score.points
      @score.played_times += 1

      if @score.save
        render json: ScoreSerializer.new(@score, include: include_list)
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
      @user = User.find_by!(qrcode: params[:user_qrcode])
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
