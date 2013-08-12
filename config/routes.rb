WaxPoetic::Application.routes.draw do
  resources :releases
  resources :artists
  root to: 'application#index'
  match '/*path' => 'application#index'
end
