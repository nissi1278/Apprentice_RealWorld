Rails.application.routes.draw do
  root 'articles#index'
  resources :tags, only: [:index]
  resources :articles, only: [:index, :new, :create, :edit, :update, :show]
end
