Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :projects, only: %i[edit update new create] do
    resources :contributors, only: %i[new create]
  end

  resources :texts, only: %i[show update] do
    resources :modifications, only: %i[index create]
  end

  resource :dashboard, only: [:show]

  resources :modifications, only: [:show] do
    member do
      patch :validate
      patch :deny
    end
  end

  resources :discussions, only: %i[show index] do
    resources :posts, only: [:create]
  end
end
