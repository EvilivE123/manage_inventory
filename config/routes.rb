Rails.application.routes.draw do
  root "products#index"
  resources :warehouses, only: [:new, :create]
  resources :inventories, only: [:update]
  resources :products, only: [:index, :edit], param: :sku_code
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
