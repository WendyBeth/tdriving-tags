Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  resources :videos do 
    resources :tags, only: [:new, :create]
  end

  resources :tags, only: [:show, :index]
end
