Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  scope '(:locale)', locale: /en|ja/ do
    devise_for :users, skip: :omniauth_callbacks
    get 'static_pages/home'
    get 'static_pages/help'
    get 'static_pages/about'
    get 'static_pages/contact'
    root 'static_pages#home'
    resources :users, only: %i[index show destroy] do
      member do
        get :following, :followers
      end
    end
    resources :microposts, only: %i[create destroy]
    resources :relationships, only: %i[create destroy]
  end
end
