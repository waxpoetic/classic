WaxPoetic::Application.routes.draw do
  devise_for :users

  resources :orders, only: %w(index show create)
  resource :cart, only: %w(show)

  resources :users, only: %w(show) do
    resources :orders, only: %w(index show create)
    resource :cart, only: %w(show)
  end

  resources :releases, only: %w(index show) do
    resources :products, only: %w(index show) do
      member { get :buy }
    end
  end

  resources :artists, only: %w(index) do
    resources :releases, only: %w(index)
  end

  get '/cart' => 'orders#cart'

  root to: 'application#index'
  match '/*path' => 'application#index'
end
