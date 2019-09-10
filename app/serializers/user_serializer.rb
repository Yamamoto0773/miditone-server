# frozen_string_literal: true

class UserSerializer < BaseSerializer
  set_type :user
  attributes :qrcode, :name

  has_one :preference
end
