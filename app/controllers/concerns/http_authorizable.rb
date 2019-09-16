# frozen_string_literal: true

module HttpAuthorizable
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate!
    raise Exceptions::HttpAuthorizable::InvalidToken unless authenticate_token
  end

  def authenticate_token
    authenticate_with_http_token do |token|
      Token.authenticated?(token)
    end
  end
end
