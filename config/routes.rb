WaxPoetic::Application.routes.draw do
  resources :releases
  resources :artists
  root to: 'application#index'
end
