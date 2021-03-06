Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }

  resources :users, only: %i[index]
  resources :integrations, only: %i[show]
  resources :categories, only: %i[index show]
  resources :products, except: %i[index] do
    resources :publishes, only: %i[show create update destroy]
    post :mass_inserting, on: :collection
    post :marketing, on: :collection
  end
  resources :vk_groups, only: :update
  resources :sites, only: :update
  resources :instructions, only: :index

  root to: 'users#index'
end
