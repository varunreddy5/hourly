  Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
    namespace :api do
      namespace :v1 do
        resources :authentication
        post :auth, to: 'authentication#create'
        resources :users do
          resources :posts
        end
      end
    end
    root 'posts#activity_feed'
    get '/activity_feed', to: 'posts#activity_feed'
    resources :users do
      member do
        get :followers, :following
      end
    end
    get '/autocomplete', to: 'users#autocomplete'
    
    resources :posts, only: [:create, :destroy, :index, :show] do
      resource :likes
      resources :comments, module: :posts
      member do
        post :share
      end
    end
    
    resources :relationships, only: [:create, :destroy]
    resources :notifications do
      collection do
        post :mark_as_read
      end
    end

    resources :chatrooms do
      resource :chatroom_users
      resources :messages
    end

    resources :direct_messages
  end
