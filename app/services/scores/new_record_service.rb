# frozen_string_literal: true

module Scores
  class NewRecordService
    def initialize(user:, params:, platform:)
      @user = user
      @params = params
      @platform = platform
    end

    def execute!
      score = Score.find_by(
        user_id: @user.id,
        music_id: @params[:music_id],
        difficulty: @params[:difficulty],
        platform: @platform
      )

      ActiveRecord::Base.transaction do
        if score
          score.played_times += 1

          score.attributes = @params.except(:max_combo) if @params[:points].to_i > score.points
          score.max_combo = @params[:max_combo] if @params[:max_combo].to_i > score.max_combo
        else
          score = @user.scores.build(@params.merge(played_times: 1, platform: @platform))
        end

        score.save!
      end

      score
    end
  end
end
