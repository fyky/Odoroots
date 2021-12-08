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
  end

  resources :events, except: [:destroy] do
    collection do
      post "confirm"
    end
    resources :reservations, only: [:new, :create, :show] do
      collection do
        post "confirm"
      end
    end
  end

  resources :reservations, only: [:index]


end
