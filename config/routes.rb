Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :projects, only: [:show, :edit, :update, :new, :create] do
    resources :contributors, only: [:new, :create]
  end

  resources :texts, only: [:show, :update] do
    resources :modifications, only: [:index, :create]
  end

  resource :dashboard, only: [:show]

  resources :modifications, only: [:show] do
    member do
      patch :validate
      patch :deny
    end
  end

  resources :discussions, only: [:show] do
    resources :posts, only: [:create]
  end
end
