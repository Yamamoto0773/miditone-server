# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    concern :users_data do
      resources :scores
      resource :preference, only: [:update, :show]
    end
    concern :statistics do
      resources :ranking, only: [:index]
      get :played_times, to: 'played_times#of_a_music', on: :member
      get :played_times, to: 'played_times#of_all_musics', on: :collection
    end

    scope :button do
      resources :users, param: :qrcode, concerns: :users_data
      resources :musics, concerns: :statistics
    end
    scope :balance_board do
      resources :users, param: :qrcode, concerns: :users_data
      resources :musics, concerns: :statistics
    end

    get 'health_check', to: 'base#health_check'
  end

  namespace :manage do
  end
end
