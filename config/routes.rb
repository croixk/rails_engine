Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/items/find_all', to: 'searches#find_all'
      get '/merchants/find', to: 'searches#find' 
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchants, only: [:index], controller: :item_merchants
      end
    end
  end

end
