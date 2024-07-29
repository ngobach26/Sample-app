Rails.application.routes.draw do
  # devise_for :users
  scope "(:locale)", locale: /en|ja/ do
    devise_for :users
    get "static_pages/home"
    get "static_pages/help"
    get "static_pages/about"
    get "static_pages/contact"
    root "static_pages#home"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
