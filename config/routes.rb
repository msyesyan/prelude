Prelude::Application.routes.draw do
  devise_for :users
  
  root :to => 'users#index'

  resources :users do
    resources :statistics
    resources :cdrs
  end
end
