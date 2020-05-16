Rails.application.routes.draw do
  root 'top_pages#index'
  get 'login', to: 'sessions#index'
  post 'login', to: 'sessions#login'
  post 'logout', to: 'sessions#logout'
  resources :users
  resources :products
  post 'search', to: 'products#search'
  get 'quick_order', to: 'products#quick_order'
  resources :free_pages, only: [:index]
end
