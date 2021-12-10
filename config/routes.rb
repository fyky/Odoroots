Rails.application.routes.draw do

  root to: 'homes#top'



  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get "unsubscribe"
      patch "withdraw"
      get "host"
      get "attend"
    end
    
    resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :events, except: [:destroy] do
    collection do
      post "confirm"
      get "search"
    end

    resource :comments, only: [:create]

    resource :favorites, only: [:create, :destroy]

    resources :reservations, only: [:new, :create, :show, :update] do
      collection do
        post "confirm"
      end
    end
  end

  resources :reservations, only: [:index]


end
