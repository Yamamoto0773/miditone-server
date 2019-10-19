# frozen_string_literal: true

class UsersData
  def initialize; end

  def call(mapper, options = {})
    mapper.resources :scores,
      path: options[:path_prefix] + 'scores'
    mapper.resource :preference,
      only: [:update, :show],
      path: options[:path_prefix] + 'preference'
  end
end
