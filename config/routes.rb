Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :tasks do
    patch 'update_status', on: :member
    resources :comments, only: [:new, :create]
    collection do
      get 'filter_by_date', to: 'tasks#filter_by_date'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"
end
