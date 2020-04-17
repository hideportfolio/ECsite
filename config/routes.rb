Rails.application.routes.draw do

    resources :items

     devise_for :end_users
     root 'end_users#show'
     get 'end_users/mypages' => 'end_users#show', as:'end_user'
     get 'end_users/mypages/edit' => 'end_users#edit', as:'edit_end_user'
     patch 'end_users/mypages' => 'end_users#update'


    devise_for :admins, controllers: {
      sessions: 'admins/sessions'
    }
      namespace :admin do
        resources :items
        resources :end_users
        resources :genres
      end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
