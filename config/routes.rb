Rails.application.routes.draw do
  resources :borrowings, only: [ :index, :destroy ]

  resources :books, only: [ :index, :show ] do
    resources :borrowings, only: [ :create ]
  end

  resources :users, only: [ :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token

  root "libraries#show"
  get "my_library", to: "libraries#show", as: "my_library"

  match "*path", to: "errors#not_found", via: :all
end
