Rails.application.routes.draw do
   
  # devise_for :users
  # devise_for :users, controllers: { registrations: 'users/registrations'}
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :apps
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'apps#index'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'log_out', to: 'devise/sessions#destroy'
  end
end
