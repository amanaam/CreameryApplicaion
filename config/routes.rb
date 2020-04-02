Rails.application.routes.draw do
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
