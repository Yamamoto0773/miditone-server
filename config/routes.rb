# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, param: :qrcode do
      resources :scores, shallow: true
      resource :preference, only: [:update, :show]
    end
    resources :musics do
      resources :ranking, only: [:index]
      get :played_times, to: 'musics#played_times_of_a_music', on: :member
      get :played_times, to: 'musics#played_times_of_all_musics', on: :collection
    end
  end

  namespace :manage do
  end
end
