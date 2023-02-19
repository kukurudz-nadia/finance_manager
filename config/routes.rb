Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'

  get 'main_pages/index'
  resources :transactions
  resources :categories

  root 'main_pages#index'
end
