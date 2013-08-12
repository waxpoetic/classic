WaxPoetic::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :releases
  resources :artists
  root to: 'application#index'
  match '/*path' => 'application#index'
end
