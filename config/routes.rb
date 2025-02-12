Rails.application.routes.draw do
  get "borrowings/create"
  get "borrowings/update"
  resources :books, only: [:index, :show]
  resources :users, only: [:new, :create]
  resource :session
  resources :passwords, param: :token
  root "libraries#show"
  get "my_library", to: "libraries#show", as: "my_library"
end
