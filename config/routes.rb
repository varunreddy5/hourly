# Rails.application.routes.draw do
#   devise_for :users
  Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
    root 'posts#index'
    # get '/login', to: 'sessions#new'
    # post '/login', to: 'sessions#create'
    # delete '/logout', to: 'sessions#destroy'
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
# end
