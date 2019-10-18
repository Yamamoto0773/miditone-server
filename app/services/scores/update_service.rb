# frozen_string_literal: true

module Scores
  class UpdateService
    def initialize(score:, params:)
      @score = score
      @params = params
    end

    def execute
      @score.points = @params[:score][:points] if @params[:score]&.key?(:points) && @params[:score][:points].to_i > @score.points
      @score.played_times += 1
      @score.save!

      @score
    rescue ActiveRecord::RecordInvalid => e
      e.record
    end
  end
end
