Clasificadoschubut::Application.routes.draw do
  
  root :to => "site#index"
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  mount Rich::Engine => '/rich', :as => 'rich'

  devise_for :users
  ActiveAdmin.routes(self)

  resources :users, :only => [:edit, :update]
  resources :publications
  resources :publication_steps

  match '/publication_steps/multifile-upload' => "publication_steps#multifile_upload"
  match '/publication_steps/multifile-publication-images-upload' => "publication_steps#multifile_publication_images_upload", as: "multifile_publication_images"  
  
  match '/auth/:provider/callback' => 'authentications#create'
  
  match '/auth/failure' => "site#index"

  match '/contact', to: "site#contact", as: "contact"
  match '/contact/send-email', to: "site#send_contact_email", as: "contact_email"

  match '/search/:event', to: "site#search", as: "search"

  match '/publications/new/to-first', to: "publications#create"
  match '/publications/new/to-categories', to: "publication_steps#show"
  match '/publications/new/to-details', to: "publication_steps#update"

  match '/show-publication/:id', to: "site#show_one_publication", as: "show_one_publication"







  match '/:event', to: "site#index", as: "index"

  #match '/update_password/:id', to: "users#update_password", as: "update_password"

end
