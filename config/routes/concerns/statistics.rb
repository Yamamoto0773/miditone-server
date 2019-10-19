# frozen_string_literal: true

class Statistics
  def initialize; end

  def call(mapper, options = {})
    mapper.resources :ranking,
      only: [:index],
      path: options[:path_prefix] + 'ranking'
    mapper.get :played_times,
      to: 'played_times#of_music',
      on: :member,
      path: options[:path_prefix] + 'played_times'
    mapper.get :played_times,
      to: 'played_times#of_all_musics',
      on: :collection,
      path: options[:path_prefix] + 'played_times'
  end
end
