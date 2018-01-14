Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :members, defaults: { format: :json }, only: [:index, :create, :show]
  resources :groups,  defaults: { format: :json }, only: [:index]
end
