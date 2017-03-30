Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

    resources :users, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :products, only: [:show, :create]
    resources :vk_groups, only: :update

    get 'welcome' => 'welcome#index', as: :welcome

    root to: 'users#index'
    match "*path", to: "application#catch_404", via: :all
end
