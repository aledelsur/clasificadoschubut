Clasificadoschubut::Application.routes.draw do

  resources :images  
  
  root :to => "site#index"
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users
  #ActiveAdmin.routes(self)

  resources :users, :only => [:edit, :update]
  resources :publications
  resources :publication_steps

    
  
  match '/auth/:provider/callback' => 'authentications#create'
  
  match '/auth/failure' => "site#index"

  match '/contact', to: "site#contact", as: "contact"
  match '/contact/send-email', to: "site#send_contact_email", as: "contact_email"

  match '/search/:event', to: "site#search", as: "search"
  match '/order/:sort', to: "site#order", as: "order"

  match '/publications/new/to-first', to: "publications#create"
  match '/publications/new/to-categories', to: "publication_steps#show"
  match '/publications/new/to-details', to: "publication_steps#update"

  match '/mark-as-sold', to: "publications#mark_as_sold", as: "mark_as_sold"

  match '/:event', to: "site#index", as: "index"

  match '/search-words/keypress', to: "site#autocomplete", as: "autocomplete"

  #match '/update_password/:id', to: "users#update_password", as: "update_password"

end
