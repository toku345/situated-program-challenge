Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :members, defaults: { format: :json }, only: [:index, :create, :show] do
    # NOTE: 本当はこうしたかったが、これだと PUT/PATCH になってしまう
    # resources :groups, only: [:update], controller: :members_groups
    # resources :meetups, only: [:update], controller: :members_meetups
    post '/groups/:id', to: 'members_groups#create'
    post '/meetups/:id', to: 'members_meetups#create'
  end
  resources :groups, defaults: { format: :json }, only: [:index, :create] do
    resources :venues, only: [:index, :create]
    resources :meetups, only: [:index, :create, :show]
  end
end
