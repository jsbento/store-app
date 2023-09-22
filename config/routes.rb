Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#home"

  post "users/sign_up", to: "users#create", as: :sign_up
  get "users/sign_up", to: "users#new", as: :new_user
  post "users/login", to: "sessions#create", as: :login
  get "users/login", to: "sessions#new", as: :new_session
  delete "users/logout", to: "sessions#destroy", as: :logout

  put "account", to: "users#update", as: :account
  get "account", to: "users#edit", as: :edit_account
  delete "account", to: "users#destroy"

  resources :items do
    resources :reviews
  end

  resources :users

  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

  resources :active_sessions, only: [:destroy] do
    collection do
      delete "destroy_all"
    end
  end
end
