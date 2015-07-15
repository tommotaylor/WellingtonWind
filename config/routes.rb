Rails.application.routes.draw do

 resources :spots, only: [:index, :show]

 get 'search', to: 'spots#search'

end
