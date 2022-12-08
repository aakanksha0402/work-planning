Rails.application.routes.draw do
  get 'health', to: 'health#index'
  namespace :api do
    namespace :v1 do
      resources :workers
      resources :shifts
    end
  end
end
