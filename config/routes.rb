Rails.application.routes.draw do
  get 'pay_grade_rates/new'
  get 'pay_grade_rates/edit'
  get 'pay_grade_rates/show'
  get 'pay_grade_rates/index'
  get 'pay_grades/new'
  get 'pay_grades/edit'
  get 'pay_grades/show'
  get 'pay_grades/index'
  get 'jobs/new'
  get 'jobs/edit'
  get 'jobs/show'
  get 'jobs/index'
  get 'shifts/new'
  get 'shifts/edit'
  get 'shifts/show'
  get 'shifts/index'
  resources :stores
  resources :employees
  resources :assignments
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  #get '/assignments/:id', to: 'assignments#terminate'
  post '/assignments/:id', to: 'assignments#terminate', as: :terminate_assignment
  get  '/employees/details/:id', to: 'employees#details', as: :details
  root to: 'home#index'
end
