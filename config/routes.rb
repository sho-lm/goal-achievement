Rails.application.routes.draw do
  root      "users#index"
  get       "/login",     to: "sessions#new"
  post      "/login",     to: "sessions#create"
  delete    "/logout",    to: "sessions#destroy"
  resources :users do
    resources :goals
    resources :work_records
  end
end
