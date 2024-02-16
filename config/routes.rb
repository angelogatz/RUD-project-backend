Rails.application.routes.draw do
  resources :annotations
  resources :users
  get "/find_users/:id", to: "users#find_users"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
