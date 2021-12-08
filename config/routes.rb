Rails.application.routes.draw do

  root to: 'homes#top'



  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    collection do
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

    resources :reservations, only: [:new, :create, :index] do
      collection do
        post "confirm"
        get "complete"
      end
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
