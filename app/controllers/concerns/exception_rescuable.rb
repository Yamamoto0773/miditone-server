# frozen_string_literal: true

module ExceptionRescuable
  extend ActiveSupport::Concern

  included do
    include ErrorRenderable

    rescue_from ActiveRecord::RecordNotFound,                   with: :record_not_found
    rescue_from ActionController::ParameterMissing,             with: :parameter_missing

    rescue_from Exceptions::HttpAuthorizable::InvalidToken,     with: :unauthorized_error
  end

  private

  def record_not_found
    render404(
      title: 'Not Found',
      messages: 'Record not found'
    )
  end

  def parameter_missing
    render400(
      messages: 'Parameter missing'
    )
  end

  def unauthorized_error
    render403(
      messages: 'Invalid authorization token'
    )
  end
end
