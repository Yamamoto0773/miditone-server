# frozen_string_literal: true

module Api
  class BaseController < ::ApplicationController
    def render_validation_errors(obj)
      render400 messages: obj.errors.full_messages
    end

    def render400(messages:)
      render_error(
        code: 400,
        title: 'Bad Request',
        messages: messages
      )
    end

    def render_error(code:, title:, messages:)
      render json: {
        code: code,
        title: title,
        messages: messages
      }, status: code
    end
  end
end
