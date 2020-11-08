Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
  mount ActionCable.server => '/cable'

  get '/items', to: 'menu_items#items'
  post '/item', to: 'menu_items#create'
  put '/item/:id', to: 'menu_items#update'
  delete '/item/:id', to: 'menu_items#destroy'

  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
end
