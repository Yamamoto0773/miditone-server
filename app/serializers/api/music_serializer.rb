# frozen_string_literal: true

module Api
  class MusicSerializer < ::Api::BaseSerializer
    set_type :music
    attributes :title, :artist
  end
end
