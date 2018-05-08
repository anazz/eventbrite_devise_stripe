Rails.application.routes.draw do
  
  root to: 'home#index'
  
  devise_for :users
  resources :events 
  resources :users
  

  # get 'events/index_all', to: 'events#index_all', as: 'index_all'

  


  get 'events/index'
  get 'events/create'
  get 'events/new'
  get 'events/destroy'
  get 'events/show'
  
  # get 'users/index'
  # get 'users/create'
  # get 'users/new'
  # get 'users/destroy'
  # get 'users/show'

  

  get 'home/index'
  get 'home/private'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  


  
end
