Rails.application.routes.draw do
  root 'projects#index'

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

  resources :tags, only: [:index, :show]
  
  devise_for :users

  resources :users, only: [:index, :show]  do
    member do
      put "follow", to: "users#follow"
    end
  end

  get "activities", to: "activities#index"
  get "notifications", to: "activities#notifications"
end
