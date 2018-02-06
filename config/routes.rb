Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :games, only: [:create, :show]
    resources :moves, only: :create
  end
end
