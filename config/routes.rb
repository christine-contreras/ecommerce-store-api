Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :users, only: [:destroy, :update]
    post "/signup", to: "users#create"
    get "/me", to: "users#show"

    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"


    get "/user-cart", to: "carts#show"
    resources :carts, only: [:index, :update]
    patch "/carts/:id/delete-item", to: "carts#delete_item"
    patch "/carts/:id/update-item-qty/:quantity", to: "carts#update_item"

    resources :categories
    resources :products
    resources :skus, only: [:create, :update, :destroy]

    post "/update-product-categories", to: "product_categories#update_product_categories"

    resources :selected_items, only: [:index, :update, :destroy]

    resources :orders, only: [:index, :update]


    post "/checkout", to: "stripe#checkout"
    post "/order-success", to: "stripe#order_success"
  
  end

  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }


end
