Rails.application.routes.draw do
  get 'customers/mypage' => 'public/customers#show', as: 'mypage'
  get 'customers/edit' => 'public/customers#edit', as: 'edit_customer'
  patch 'customers' => 'public/customers#update'
  put 'customers' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'confirm_unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw_customer'
  put 'customers/withdraw' => 'public/customers#withdraw'

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
  end

  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'items#top'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/confirm' => 'orders#error'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :index, :create, :show]
  end
end
