Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :games, only: [:create, :show]
    resources :marks, only: :create
  end
end
