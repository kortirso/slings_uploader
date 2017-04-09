Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

    resources :users, only: [:index, :show]
    resources :categories, only: [:index, :show]
    resources :products, except: [:index] do
        resources :publishes, only: [:show, :create, :update, :destroy]
        post :mass_inserting, on: :collection
    end
    resources :vk_groups, only: :update

    get 'welcome' => 'welcome#index', as: :welcome

    root to: 'users#index'
    match "*path", to: "application#catch_404", via: :all
end
