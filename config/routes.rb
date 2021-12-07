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


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
