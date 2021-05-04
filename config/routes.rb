Rails.application.routes.draw do
  root 'top_pages#index'
  get 'top_pages/:id/download', to: 'top_pages#download', as: 'top_pages'
  get 'login', to: 'sessions#index'
  post 'login', to: 'sessions#login'
  post 'logout', to: 'sessions#logout'
  post 'password_reset', to: 'sessions#password_reset'
  get 'reset_password/:user_id', to: 'sessions#reset_password'
  post 'reset_user_password/:user_id', to: 'sessions#reset_user_password'
  get 'complite_message', to: 'sessions#complite_message'
  resources :users do
    resources :order_histories do
      get 'search', on: :collection
      post 'cart_add', on: :collection
      post 'one_cart_add', to: 'order_histories#one_cart_add'
    end
    resources :my_lists do
      delete 'product_delete'
      post 'product_add_cart', on: :collection
    end
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
      post 'quick_order_products', to: 'products#quick_order_products'
      post 'show_create', to: 'products#show_create'
      post 'mylist_create', to: 'products#mylist_create'
    end
  end
  resources :free_pages, only: [:index]
  resources :inqueries, only: [:index] do
    get 'search', on: :collection
  end

  resources :contacts, only: [:new, :create] do
    post 'confirm', on: :collection
  end
  get 'complite', to: 'contacts#complite'
  get 'sitemap', to: 'sitemaps#sitemap'
  get 'mypage', to: 'mypages#mypage'

  namespace :admin do
    get 'login', to: 'sessions#index'
    post 'login', to: 'sessions#login'
    post 'logout', to: 'sessions#logout'
    post 'password_reset', to: 'sessions#password_reset'
    get 'complite_message', to: 'sessions#complite_message'
    get 'dashboard', to: 'dashboards#index'
    get 'hazimeni', to: 'dashboards#hazimeni'
    resources :informations do
      post 'change_release', on: :member
      post 'info_title', on: :collection
      get 'download', on: :member
    end
    # post 'informations/change_release/:id', to: 'informations#change_release', as: :informations_change_release
    resources :images
    get 'banner_index', to: 'images#banner_index'
    get 'witch_new_or_edit', to: 'images#witch_new_or_edit'
    get 'banner_new', to: 'images#banner_new'
    get 'banner_edit/:id', to: 'images#banner_edit', as: 'banner_edit'
    post 'banner_create', to: 'images#banner_create'
    patch 'banner_update/:id', to: 'images#banner_update', as: 'banner_update'
    get 'product_page_edit', to: 'product_pages#edit'
    post 'product_page_create', to: 'product_pages#create'
    resources :free_pages do
      post 'change_release', on: :member
      post 'edit_change', on: :member
    end
    resources :page_contents, only: [:destroy, :create, :update]
    resources :inqueries do
      get 'select', on: :collection
    end
    resources :questions
    resources :products do
      collection do
        get 'search'
        get 'category'
        get 'category_edit'
        get 'child_category'
        post 'category_create'
        patch 'category_update'
      end
      post 'change_release', on: :member
    end
    resources :order_managements do
      collection do
        get 'user_search'
        get 'address_search'
        get 'product_search'
        get 'order_history'
        get 'order_history_search'
        post 'select_product_delete'
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
    resources :shops do
      patch 'open_or_close', on: :member
    end
    resources :mail_settings
    resources :payment_method_settings
    resources :shipping_settings
    resources :cart_memos
    resources :member_ranks do
      collection do
        patch 'bluk_update'
      end
    end
    resources :holiday_settings do
      collection do
        patch 'bluk_update'
      end
    end
    resources :shop_holidays do
      post 'update_set_shop_holiday'
      patch 'update_calender_display', on: :collection
    end
    resources :users do
      get 'password_reset', on: :member
      patch 'reset', on: :member
    end
  end
end
