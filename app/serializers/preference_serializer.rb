# frozen_string_literal: true

class PreferenceSerializer < BaseSerializer
  set_type :preference
  attributes :note_speed, :se_volume, :platform
end
