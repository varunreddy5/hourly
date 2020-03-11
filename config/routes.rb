  Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
    namespace :api do
      namespace :v1 do
        resources :users do
          resources :posts
        end
      end
    end
    root 'posts#index'
    get '/activity_feed', to: 'posts#activity_feed'
    resources :users do
      member do
        get :followers, :following
      end
    end
    resources :posts, only: [:create, :destroy, :index, :show] do
      resource :likes
      resources :comments, module: :posts
    end
    resources :relationships, only: [:create, :destroy]
    resources :notifications do
      collection do
        post :mark_as_read
      end
    end
  end
