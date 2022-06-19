Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index"

  resources :users, only: [:index] do
    get  :become, on: :member
  end

  resources :detect_lists, only: [:index, :new, :create, :edit, :update]
end
