module Platform
  extend ActiveSupport::Concern

  included do
    enumerize :platform,
      in: { button: 'button', balance_board: 'balance_board' }, scope: :shallow
  end
end
