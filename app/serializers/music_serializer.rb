# frozen_string_literal: true

class MusicSerializer < BaseSerializer
  set_type :music
  attributes :title, :artist
end
