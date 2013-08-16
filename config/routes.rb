WaxPoetic::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :releases

  resources :artists do
    resources :releases
  end

  root to: 'application#index'
  match '/*path' => 'application#index'
end
