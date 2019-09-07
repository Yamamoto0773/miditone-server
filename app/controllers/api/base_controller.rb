# frozen_string_literal: true

module Api
  class BaseController < ::ApplicationController

    def render_errors(obj)
      render400 obj.errors.messages
    end

    def render400(details)
      render json: {
        title: 'Bad Request',
        status: 400,
        details: obj.errors.messages
      }
    end
  end
end
