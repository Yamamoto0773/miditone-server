# frozen_string_literal: true

module Scores
  class UpdateService
    def initialize(score:, params:)
      @score = score
      @params = params
    end

    def execute!
      @score.points = @params[:points] if @params.key?(:points) && @params[:points].to_i > @score.points
      @params.delete(:points)
      @score.attributes = @params
      @score.played_times += 1
      @score.save!
    end
  end
end
