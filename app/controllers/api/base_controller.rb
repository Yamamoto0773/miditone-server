# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include ExceptionRescuable
    include ApplicationHelper
    include HttpAuthorizable

    before_action :authenticate!

    def health_check
      render json: {
        title: 'Hello! This is miditone-server!',
        comment: 'Your Request is so GOOD!',
        auth: 'Authenticated successfully!',
        luck: "#{rand(0..10) * 10}% lucky today!"
      }
    end

    private

    def platform
      unless @platform
        resources = request.fullpath.split('/')
        scope = resources.find { |r| r == 'button' } || resources.find { |r| r == 'board' }
        @platform = scope
      end

      @platform
    end
  end
end
