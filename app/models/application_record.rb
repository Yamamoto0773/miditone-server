# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  extend Enumerize

  self.abstract_class = true
end
