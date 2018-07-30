Rails.application.routes.draw do
  resources :users
  get 'users/new'

  root 'static_pages#home'
  get  '/login',   to: 'static_pages#login'
  get  '/about',   to: 'static_pages#about'
  get  '/help',    to: 'static_pages#help'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
end