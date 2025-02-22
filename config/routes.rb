Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "baseball_games#scoreboard"

  resources :games, only: [ :show, :edit, :update ]
  get "games/show"
  get "games/edit"
  get "games/update"
  get "games/scoreboard"

  resources :baseball_games, only: [ :show, :edit, :update ]
  get "baseball_games/scoreboard"
  get "/scoreboard", to: "baseball_games#scoreboard"
end
