Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index"

  resources :users, only: [:index] do
    get  :become, on: :member
  end

  resources :detect_lists, except: [:show] do
    get :move, on: :member

    resources :detect_items, only: [:new, :create], module: :detect_lists
  end

  resources :detect_items, only: [] do
    get :move, on: :member
  end
end
