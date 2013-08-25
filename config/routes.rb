WaxPoetic::Application.routes.draw do

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes self

  resources :orders, only: %w(index show create)
  resource :cart, only: %w(show)

  resources :releases, only: %w(index show) do
    resources :products, only: %w(index show) do
      member { get :buy }
    end
  end

  resources :artists, only: %w(index) do
    resources :releases, only: %w(index)
  end

  root to: 'application#index'
  match '/*path' => 'application#index'
end
