Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  match 'tag-suggestions' => "tags#suggestions", via: :get

  resources :videos do 
    resources :tags, only: [:new, :create]
  end

  resources :tags, only: [:show, :index]

  namespace :admin do 
    resources :tags
  end
end
