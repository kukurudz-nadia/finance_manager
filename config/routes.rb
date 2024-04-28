Rails.application.routes.draw do
  root 'main_pages#index'
  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'

  resources :transactions
  resources :categories
end
