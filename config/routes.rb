Rails.application.routes.draw do
  root 'application#index'
  get 'dashboard', to: 'dashboard#index'
  devise_for :users
  resources :meals
  resources :ingredients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
