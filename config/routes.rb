Rails.application.routes.draw do

  get 'main_pages/index'
  resources :transactions
  resources :categories

  root 'main_pages#index'
end
