Clasificadoschubut::Application.routes.draw do
  devise_for :users

  resources :users, :only => [:edit, :update]
  resources :publications
  resources :publication_steps
  
  match '/auth/:provider/callback' => 'authentications#create'
  root :to => "site#index"
  match '/auth/failure' => "site#index"

  match '/:event', to: "site#index", as: "index"
  match '/search/:event', to: "site#search", as: "search"

  #match '/update_password/:id', to: "users#update_password", as: "update_password"

end
