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
    resources :carts do
      post 'confirm', on: :member
      get 'complite'
    end
    member do
      get 'password_edit'
      patch 'password_reset'
    end
  end
  resources :products do
    collection do
      get 'search', to: 'products#search'
      get 'quick_order', to: 'products#quick_order'
      post 'quick_order', to: 'products#quick_order'
      post 'show_create', to: 'products#show_create'
    end
  end
  resources :free_pages, only: [:index]
  resources :inqueries, only: [:index]
  resources :contacts
  get 'complite', to: 'contacts#complite'
  get 'sitemap', to: 'sitemaps#sitemap'
  get 'mypage', to: 'mypages#mypage'

  namespace :admin do
    resources :informations
    resources :images
    get 'banner_index', to: 'images#banner_index'
    post 'banner_create', to: 'images#banner_create'
    patch 'banner_update', to: 'images#banner_update'
    get 'product_page_edit', to: 'product_pages#edit'
    post 'product_page_create', to: 'product_pages#create'
    resources :free_pages
    resources :page_contents, only: [:destroy, :create]
    resources :inqueries
    resources :questions
    resources :products do
      collection do
        get 'search'
        get 'category'
        get 'category_edit'
        post 'category_create'
        patch 'category_update'
      end
    end
    resources :order_managements do
      collection do
        get 'user_search'
        get 'order_history'
        get 'order_history_search'
      end
    end
    resources :shipments do
      collection do
        get 'search'
      end
    end
    resources :members do
      collection do
        get 'search'
      end    end
    resources :groups do
      collection do
        get 'search'
      end    end
    resources :addresses do
      collection do
        get 'search'
        get 'user_search'
      end
    end
    resources :shipping_origins do
      collection do
        get 'search'
      end
    end
    resources :stock_managements do
      collection do
        get 'search'
        get 'bluk_edit'
        patch 'bluk_update'
      end
    end
  end
end
