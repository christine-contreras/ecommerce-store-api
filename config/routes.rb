Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :users, only: [:destroy, :update]
    post "/signup", to: "users#create"
    get "/me", to: "users#show"

    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"


    get "/user-cart", to: "carts#show"

    resources :categories
    resources :products
    resources :skus, only: [:index, :create, :update, :destroy]

    post "/update-product-categories", to: "product_categories#update_product_categories"
  
  end

  # post "rails/active_storage/direct_uploads", to: "direct_uploads#create"

  # get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }


end
