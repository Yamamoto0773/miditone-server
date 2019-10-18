# frozen_string_literal: true

module Api
  class ScoresController < BaseController
    include ScoresGettable

    before_action :set_user, only: %i[index create]
    before_action :set_score, except: %i[index create]

    def index
      scores = if given_difficulty_params?
                  get_platform_scores(parent: @user).where(difficulty: params[:difficulty]).order(:music_id)
                else
                  get_platform_scores(parent: @user)
                end

      render json: ScoreSerializer.new(scores, include: include_list)
    end

    def show
      render json: ScoreSerializer.new(@score, include: include_list)
    end

    def create
      score = @user.scores.build(score_params.merge(played_times: 1, platform: platform))

      if @score.save
        render json: ScoreSerializer.new(@score, include: include_list), status: :created
      else
        render_validation_errors @score
      end
    end

    def update
      score = Scores::UpdateService.new(score: @score, params: score_params).execute

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
