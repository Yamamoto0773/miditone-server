# frozen_string_literal: true

class UserSerializer < BaseSerializer
  set_type :user
  attributes :qrcode, :name, :button_total_score, :board_total_score

  has_many :preferences
end
