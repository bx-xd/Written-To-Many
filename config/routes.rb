Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :projects, only: %i[edit update new create] do
    resources :contributors, only: %i[new create]
    resources :discussions, only: %i[index create]
  end

  resources :texts, only: %i[show update] do
    resources :modifications, only: [:create]
  end

  resource :dashboard, only: [:show]

  resources :modifications, only: %i[show update] do
    member do
      patch :validate
      patch :deny
    end
  end

  resources :discussions, only: %i[show] do
    resources :posts, only: [:create]
  end
end
