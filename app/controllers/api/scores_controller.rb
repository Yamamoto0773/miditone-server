# frozen_string_literal: true

module Api
  class ScoresController < BaseController
    include ScoresGettable

    before_action :set_user, only: %i[index new_record]
    before_action :set_score, except: %i[index new_record]

    def index
      scores = if given_difficulty_params?
                 get_platform_scores(parent: @user).where(difficulty: params[:difficulty])
               else
                 get_platform_scores(parent: @user)
               end

      scores = scores.order(:music_id, :difficulty).includes([:music])

      render json: ScoreSerializer.new(scores, include: include_list)
    end

    def show
      render json: ScoreSerializer.new(@score, include: include_list)
    end

    # def create
    #   score = @user.scores.build(score_params.merge(played_times: 1, platform: platform))

    #   if score.save
    #     render json: ScoreSerializer.new(score, include: include_list), status: :created
    #   else
    #     render_validation_errors score
    #   end
    # end

    # def update
    #   if score.update(score_params)
    #     render json: ScoreSerializer.new(score, include: include_list), status: :created
    #   else
    #     render_validation_errors score
    #   end
    # end

    def new_record
      score = Scores::NewRecordService.new(user: @user, params: score_params, platform: platform).execute!

      render json: ScoreSerializer.new(score, include: include_list)
    rescue ActiveRecord::RecordInvalid => e
      render_validation_errors e.record
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
      params.require(:score).permit(
        :music_id,
        :difficulty,
        :points,
        :max_combo,
        :critical_count,
        :correct_count,
        :nice_count,
        :miss_count
      )
    end

    def given_difficulty_params?
      Score.difficulty.values.include?(params[:difficulty])
    end

    def include_list
      %i[music user]
    end
  end
end
