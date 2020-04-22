Rails.application.routes.draw do
  resources :stores
  resources :employees
  resources :assignments
  resources :sessions
  resources :jobs
  resources :shifts
  resources :pay_grades
  resources :pay_grade_rates
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  post '/assignments/:id', to: 'assignments#terminate', as: :terminate_assignment
  get  '/employees/details/:id', to: 'employees#details', as: :details
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  root to: 'home#index'
end
