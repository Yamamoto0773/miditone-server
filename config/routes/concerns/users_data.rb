# frozen_string_literal: true

class UsersData
  def initialize; end

  def call(mapper, options = {})
    mapper.resources :scores,
      only: [:index, :show, :destroy],
      path: options[:path_prefix] + 'scores' do
      mapper.put :new_record, on: :collection
    end
    mapper.resource :preference,
      only: [:update, :show],
      path: options[:path_prefix] + 'preference'
  end
end
