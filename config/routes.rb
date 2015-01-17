Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  resources :videos do 
    resources :tags, only: [:new]
  end
end
