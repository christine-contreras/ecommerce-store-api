# eCommerce Site API

This API is a eCommerce website API where you can make RESTful CRUD calls to a server to organize categories, products, skus, and orders.
You can use this API in conjunction with my front-end eCommerce app [see the repo](https://github.com/christine-contreras/ecommerce-store-client)

## Technologies Used in This API

- Ruby on Rails
- ActiveRecord
- PostgreSQL
- Bcrypt
- Active Model Serializers
- AWS with Active Record
- Stripe

## How To Use

How to install and run this API:

```sh
bundle install

# create migrations with activerecord
rails db:migrate

# if you would like to use seed data
rails db:seed

# start server
rails s
```

RoR uses port 3000 by default

## Backend Relationships

```rb
Cart        User ---------------> Orders
|           :first_name           :user_id
|           :last_name            :amount
|           :email                :address
|           :password_digest      :status
|           :address              :session_id
|            |                    :invoice
|            |                    :email
|            |                    :name
|            |                      |
|            V                      |
---------> SelectedItem <------------
            :sku_id
            :order_id
            :cart_id
            :quantity
            ^
            |
            |
          SKU <------------- Product ------ > ProductCategory <---- Category
          :product_id        :title           :product_id           :name
          :size              :description     :category_id          :description
          :color                                                    :isActive
          :price
          :quantity
```

## Example Calls You Can Make With API

### Users and Sessions

You can make the following CRUD calls for the users and sessions

- CREATE users
- GET/RETRIEVE an individual user
- DELETE a user
- UPDATE a user
- CREATE a session
- DESTROY a session

routes

```rb
Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:destroy, :update]
    post "/signup", to: "users#create"
    get "/me", to: "users#show"

    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end

end

```

user data output

```js
{
id: 3,
isAdmin: false,
email: "jane@gmail.com",
first_name: "Jane",
last_name: "Doe",
address: {
city: "Irvine",
country: "US",
line1: "123 Street",
line2: "#123",
postal_code: "12345",
state: "CA"
},
stripe_id: "cus_KzhxxuVSmfeCix",
orders: [
{
id: 16,
amount: "90.0",
address: {
city: "Irvine",
country: "US",
line1: "123 Street",
line2: "#123",
postal_code: "12345",
state: "CA"
},
name: "Jane Doe",
email: "jane@gmail.com",
session_id: "cs_a1LtXArKz8QWXrOpdTutf7fKXfmDenyj4LRRJiRjBIA3G6BVCB7t123",
invoice: "1C691FA0-16",
status: "Pending",
created_at: "2022-01-19T18:05:57.608Z",
updated_at: "2022-01-19T18:05:57.636Z",
selected_items: [
{
id: 24,
quantity: 1,
price: "80.0",
sku: {
id: 1,
size: "one size",
color: "Gold",
price: "80.0",
quantity: 8,
image_url: "https://app-dev.s3.us-east-2.amazonaws.com/product-bracelet-1-gold.jpg",
product: {
id: 1,
title: "Harper's Bracelet",
description: "14K gold plated brass. Layering Options are endless. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
}
}
}
]
},
]
}
```

### Carts and Selected Items

You can make the following API calls for carts and selected items. Carts and tied with a browser rather than a user. When a sku is added to a cart it creates a selected item. You are able to delete the item from your cart or update the quantity.

- CREATE cart
- GET/RETRIEVE a cart
- CREATE a selected item
- UPDATE a selected item
- DESTROY a selected item

routes

```rb
Rails.application.routes.draw do
  namespace :api do
    get "/user-cart", to: "carts#show"
    resources :carts, only: [:update]
    patch "/carts/:id/delete-item", to: "carts#delete_item"
    patch "/carts/:id/update-item-qty/:quantity", to: "carts#update_item"
  end

end

```

how a cart is created or shown

```rb
class Api::CartsController < ApplicationController
    def show
        if session.include? :cart_id
            set_cart
        else
            create_cart
        end

        render json: @cart, include: ['selected_items', 'selected_items.sku']
    end

    private

    def set_cart
        @cart = Cart.find_by(id: session[:cart_id])
    end

    def create_cart
        @cart = Cart.create
        session[:cart_id] = @cart.id
        @cart
    end
end
```

custom routes to update or delete cart items

```rb
class Api::CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    before_action :set_cart, only: [:delete_item, :update_item ]
    skip_before_action :authorize

    def delete_item
        item = set_selected_item
        item.destroy
        render json: @cart, include: ['selected_items', 'selected_items.sku'], status: :accepted
    end

    def update_item
        item = set_selected_item
        item.update(quantity: params[:quantity])
        render json: @cart, include: ['selected_items', 'selected_items.sku'], status: :accepted
    end

    private

    def set_cart
        @cart = Cart.find_by(id: session[:cart_id])
    end

    def set_selected_item
        @cart.selected_items.find_by(id: params[:selected_item_id])
    end

    def render_not_found_response
        render json: { errors: ['No Cart Found'] }, status: :not_found
    end
end

```

### Categories

You can make the following CRUD calls for categories. Must be an admin in order to create, update, and delete categories.

- CREATE a category
- GET/RETRIEVE all categories
- DELETE a category
- UPDATE a category

routes

```rb
Rails.application.routes.draw do
  namespace :api do
    resources :categories
  end

end

```

user data output

```js
[
    {
id: 4,
name: "Necklaces",
description: "Make a statement with these one-of-a-kind pieces.",
products_slotted: 4,
isActive: true,
image_url: "image URL here",
hasImage?: "image attached",
products: [
{
id: 3,
title: "Harper's Necklace Layering Set",
description: "This layering set includes Harper's mini necklace and pendant necklace. 14K gold plated brass. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
quantity: 1,
isActive: "active",
isSlotted: "yes",
options: [
{
color: "Gold",
image_url: "image URL here",
sizes: [
{
size: "one size",
quantity: 19
}
],
price: "120.0"
}
],
best_seller: false,
new_arrival: true,
skus: [
{
id: 9,
size: "one size",
color: "Gold",
price: "120.0",
quantity: 19,
image_url: "image URL here",
hasImage?: "image attached"
}
]
}
]
}
]
```

### Products, SKUs, and Product Categories

You can make the following API calls for products and skus, and product categories. Must be an admin in order to create, update, and delete products, skus, and product categories.

- CREATE a product
- GET/RETRIEVE all products
- DELETE a product
- UPDATE a product
- CREATE a SKU
- UPDATE a SKU
- DESTROY a SKU
- CREATE a productcategory
- DESTROY a productcategory

routes

```rb
Rails.application.routes.draw do
  namespace :api do
    resources :products
    resources :skus, only: [:create, :update, :destroy]
    post "/update-product-categories", to: "product_categories#update_product_categories"
  end

end

```

custom route to slot products to categories

```rb
class Api::ProductCategoriesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def update_product_categories
        product_id = params[:product_id]
        create_list = params[:create_list]
        delete_list = params[:delete_list]

        # create list
        if !create_list.empty?
            create_list.each {|id| ProductCategory.create(category_id: id, product_id: product_id)}
        end

        # delete list
        if !delete_list.empty?
            delete_list.each {|id| ProductCategory.destroy_by(category_id: id, product_id: product_id)}
        end

        product_categories = ProductCategory.filter_by_product(product_id)
        render json:  product_categories, status: :created
    end


    private

    def render_not_found_response
        render json: { errors: ['Product Category Not Found'] }, status: :not_found
    end
end

```

### Orders and Stripe Checkout

You can make the following calls for orders and checking out for stripe. You must be an admin to update orders.

- CREATE an order
- GET/RETRIEVE all orders
- GET/RETRIEVE an order
- UPDATE an order
- CREATE a stripe session

routes

```rb
Rails.application.routes.draw do
  namespace :api do
    resources :products
    resources :skus, only: [:create, :update, :destroy]
    post "/update-product-categories", to: "product_categories#update_product_categories"
  end

end

```

custom route to create a stripe checkout

```rb
class Api::StripeController < ApplicationController
    before_action :set_stripe_key
    skip_before_action :authorize

    def checkout
        # format items for a stripe session
        shipping_amount = params[:shipping].to_i * 100
        orderItems = params[:items].collect do |item|
            selected_item = SelectedItem.find_by(id: item)

            {
                price_data: {
                    currency: 'usd',
                    product_data: {
                        name: selected_item.sku.product.title,
                        images: [selected_item.sku.image_url]
                    },
                    unit_amount: selected_item.price.to_i * 100

                },
                quantity: selected_item.quantity,

             }

        end

        # create stripe session
        session = Stripe::Checkout::Session.create({
        line_items: orderItems,
        payment_method_types: ['card'],
        shipping_address_collection: {
            allowed_countries: ['US', 'CA'],
            },
            shipping_options: [
            {
                shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: shipping_amount,
                    currency: 'usd',
                },
                display_name: 'Standard shipping',
                # Delivers between 5-7 business days
                delivery_estimate: {
                    minimum: {
                    unit: 'business_day',
                    value: 5,
                    },
                    maximum: {
                    unit: 'business_day',
                    value: 7,
                    },
                }
                }
            },
            {
                shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: 1500,
                    currency: 'usd',
                },
                display_name: 'Next day air',
                # Delivers in exactly 1 business day
                delivery_estimate: {
                    minimum: {
                    unit: 'business_day',
                    value: 1,
                    },
                    maximum: {
                    unit: 'business_day',
                    value: 1,
                    },
                }
                }
            },
            ],
        mode: 'payment',
        success_url:  ENV["WEBSITE_URL"] + '/order-confirmation?session_id={CHECKOUT_SESSION_ID}',
        cancel_url:    ENV["WEBSITE_URL"],
        })

        render json: {url: session.url}, status: :see_other
    end

    # once redirected back to website
    def order_success
        order = Order.find_by(session_id: params[:session_id])

        if !order
            create_order
            update_items
        else
            @order = order
        end

        render json: @order, include: ['user', 'selected_items', 'selected_items.sku'], status: :accepted
    end


    private

    def set_stripe_key
        Stripe.api_key = ENV["STRIPE_API_KEY"]
    end

    def create_order
        session = Stripe::Checkout::Session.retrieve(params[:session_id])
        customer = Stripe::Customer.retrieve(session.customer)
        @current_user.update(stripe_id: customer.id)
        @order = @current_user.orders.create(
            session_id: params[:session_id],
            address: session.shipping.address,
            name: customer.name,
            email: customer.email,
            amount: session.amount_total / 100,
            status: 'Pending'
            )
        @order.invoice = "#{customer.invoice_prefix}-#{@order.id}"
        @order.save
    end

    def update_items
        params[:items].each do |item|
            selected_item = SelectedItem.find_by(id: item)
            sku_qty = selected_item.sku.quantity - selected_item.quantity
            selected_item.sku.update(quantity: sku_qty)
            selected_item.update(order_id: @order.id, cart_id: nil)
        end
    end
end

```
