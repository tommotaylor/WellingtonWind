Rails.application.routes.draw do

 get 'home', to: 'spots#index'

 resources :spots, only: [:index, :show]

 get 'search', to: 'spots#search'

 resources :users, except: :destroy
 get 'register', to: 'users#new'

 get 'sign_in', to: 'sessions#new'
 post 'sign_in', to: 'sessions#create'
 get 'sign_out', to: 'sessions#destroy'

 get 'favourites', to: 'favourites#index'
 post 'update_favourites', to: 'favourites#update_favourites'

 resources :favourites, only: [:create, :destroy]

end
