# frozen_string_literal: true

class Music < ApplicationRecord
  validates :title, :artist,
    presence: true
end
