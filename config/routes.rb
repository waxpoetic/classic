WaxPoetic::Application.routes.draw do
  resources :orders


  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes self

  resources :users, only: %w(show) do
    resources :orders
  end

  resources :releases, only: %w(index show) do
    resources :products
  end

  resources :artists, only: %w(index) do
    resources :releases, only: %w(index)
  end

  root to: 'application#index'
  match '/*path' => 'application#index'
end
