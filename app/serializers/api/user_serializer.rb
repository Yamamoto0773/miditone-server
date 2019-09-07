# frozen_string_literal: true

module Api
  class UserSerializer < ::Api::BaseSerializer
    set_type :user
    attributes :qrcode, :name
  end
end
