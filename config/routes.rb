Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
  
    root 'posts#index'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/activity_feed', to: 'posts#activity_feed'
    resources :users do
      member do
        get :followers, :following
      end
    end
    resources :posts, only: [:create, :destroy, :index] do
      
      resource :likes
      resources :comments, module: :posts
    end
  
    resources :relationships, only: [:create, :destroy]
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
