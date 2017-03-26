Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

    resources :users, only: :index

    get 'welcome' => 'welcome#index', as: :welcome

    root to: 'users#index'
end
