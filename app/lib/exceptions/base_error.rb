# frozen_string_literal: true

module Exceptions
  class BaseError < StandardError
    attr_accessor :message

    def initialize(message: nil)
      @message = message
    end

    def error_code
      self.class.to_s.split('::').last.underscore
    end
  end
end
