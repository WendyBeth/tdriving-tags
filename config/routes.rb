Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  get 'tag-suggestions', controller: 'tags', action: 'suggestions'
  get 'tag-cloud', controller: 'tags', action: 'cloud'

  resources :videos do 
    resources :tags, only: [:new, :create]
  end

  resources :tags, only: [:show, :index]

  namespace :admin do 
    resources :tags
  end
end
