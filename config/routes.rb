Rails.application.routes.draw do
  root 'activities#index'

  resources :projects do
    resources :feedbacks, only: :create do
      resources :replies, only: :create
      member do
        put "like", to: "feedbacks#like"
      end
    end
    member do
      put "like", to: "projects#like"
    end
  end
  
  devise_for :users

  resources :users, only: [:index, :show]  do
    member do
      put "follow", to: "users#follow"
    end
  end

  get "predictions", to: "api#predictions"

  get "search", to: "searches#search"

  get "discover", to: "misc#discover"

  get "notifications", to: "activities#notifications"
end
