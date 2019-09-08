# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users do
      resources :scores, shallow: true
    end
    resources :musics
  end

  namespace :manage do
  end
end
