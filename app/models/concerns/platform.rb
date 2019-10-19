# frozen_string_literal: true

module Platform
  extend ActiveSupport::Concern

  included do
    enumerize :platform,
      in: { button: 'button', board: 'board' }, scope: true
  end
end
