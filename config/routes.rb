Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'projects#index'
  resources :projects do
    resources :feedbacks, only: [:create, :destroy] do
      member do
        put "like", to: "feedbacks#like"
      end
    end
  end
  resources :tags, only: [:index, :show]
  devise_for :users
end
