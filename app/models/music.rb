# frozen_string_literal: true

class Music < ApplicationRecord
  has_many :scores, dependent: :destroy

  validates :title, :artist,
            presence: true
end
