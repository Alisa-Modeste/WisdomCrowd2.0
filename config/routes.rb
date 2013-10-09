WisdomCrowd::Application.routes.draw do
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'root#index'

  resource :session, only: [:new, :create, :destroy]

  resources :users
  resources :questions do
    resources :answers, only: [:create]
  end

  resources :answers, only: :show
  resource :search, only: [:create]

end
