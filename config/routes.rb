Rails.application.routes.draw do
  resources :users, only: :update
end
