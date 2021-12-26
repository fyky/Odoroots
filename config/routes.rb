Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: 'homes#top'
  get "about" => "homes#about"

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  get "calendar" => "users#calendar"
  get "follow" => "users#follow"


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
        post "back"
      end
    end
  end

  resources :reservations, only: [:index]

  resources :notifications, only: [:index]
  resources :favorites, only: [:index]

  resources :messages, only: [:create]

  resources :rooms, only: [:create,:show, :index]

end
