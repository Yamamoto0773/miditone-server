# frozen_string_literal: true

module ExceptionRescuable
  extend ActiveSupport::Concern

  included do
    include ErrorRenderable

    rescue_from ActiveRecord::RecordNotFound, with: record_not_found
  end

  def record_not_found
    render404(
      titie: 'Not found'
    )
  end
end
