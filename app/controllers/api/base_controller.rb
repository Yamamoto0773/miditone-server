# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include ExceptionRescuable
    include ApplicationHelper
  end
end
