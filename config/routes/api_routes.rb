# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    concern :users_data, UsersData.new
    concern :statistics, Statistics.new

    resources :users, param: :qrcode do
      concerns :users_data, path_prefix: 'button/'
      concerns :users_data, path_prefix: 'board/'
    end

    resources :musics do
      concerns :statistics, path_prefix: 'button/'
      concerns :statistics, path_prefix: 'board/'
    end

    get 'health_check', to: 'base#health_check'
  end

  namespace :manage do
  end
end
