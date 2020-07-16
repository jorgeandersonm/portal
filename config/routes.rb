Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :power_generators, only: [:index, :show] do
    member do
      get :calculate_freight
    end
    collection do 
      get :list
    end
  end
end
