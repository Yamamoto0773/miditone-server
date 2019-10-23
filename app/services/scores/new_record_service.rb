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
          score.attributes = @params if @params.key?(:points) && @params[:points].to_i > score.points
        else
          score = @user.scores.build(@params.merge(played_times: 1, platform: @platform))
        end

        score.save!
      end

      score
    end
  end
end
