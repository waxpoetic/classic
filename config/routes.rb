WaxPoetic::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :releases, only: %w(index show)

  resources :artists, only: %w(index) do
    resources :releases, only: %w(index)
  end

  root to: 'application#index'
  match '/*path' => 'application#index'
end
