Rails.application.routes.draw do
  root "articles#index"
  resources :tags, only: [ :index ]
  resources :users, only: [ :new, :create ]
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :articles

  get "*path", to: "application#render_404"
end
