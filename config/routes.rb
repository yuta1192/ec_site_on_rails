Rails.application.routes.draw do
  root 'top_pages#index'
  get 'login', to: 'sessions#index'
  post 'login', to: 'sessions#login'
  post 'logout', to: 'sessions#logout'
  resources :users do
    resources :order_histories do
      get 'search', on: :collection
    end
    resources :my_lists
    resources :addresses
    member do
      get 'password_edit'
      patch 'password_reset'
    end
  end
  resources :products do
    collection do
      get 'search', to: 'products#search'
      get 'quick_order', to: 'products#quick_order'
    end
  end
  resources :free_pages, only: [:index]
  resources :inqueries, only: [:index]
  resources :contacts
  get 'complite', to: 'contacts#complite'
  get 'sitemap', to: 'sitemaps#sitemap'
  get 'mypage', to: 'mypages#mypage'
end
