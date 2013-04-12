Clasificadoschubut::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  devise_for :users

  resources :users, :only => [:edit, :update]
  resources :publications
  resources :publication_steps

  match '/publication_steps/multifile-upload' => "publication_steps#multifile_upload"
  match '/publication_steps/multifile-publication-images-upload' => "publication_steps#multifile_publication_images_upload", as: "multifile_publication_images"  
  
  match '/auth/:provider/callback' => 'authentications#create'
  root :to => "site#index"
  match '/auth/failure' => "site#index"

  match '/contact', to: "site#contact", as: "contact"
  match '/contact/send-email', to: "site#send_contact_email", as: "contact_email"

  match '/search/:event', to: "site#search", as: "search"

  match '/publications/new/to-first', to: "publications#create"
  match '/publications/new/to-categories', to: "publication_steps#show"
  match '/publications/new/to-details', to: "publication_steps#update"









  match '/:event', to: "site#index", as: "index"

  #match '/update_password/:id', to: "users#update_password", as: "update_password"

end
