Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', sessions: 'sessions' }

    resources :users, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :products, except: [:index] do
        resources :publishes, only: [:show, :create, :update, :destroy]
        post :mass_inserting, on: :collection
        post :upload_all_db, on: :collection
        post :marketing, on: :collection
    end
    resources :vk_groups, only: :update
    resources :sites, only: :update
    resources :instructions, only: :index

    get 'welcome' => 'welcome#index', as: :welcome

    root to: 'users#index'
    match "*path", to: "application#catch_404", via: :all
end
