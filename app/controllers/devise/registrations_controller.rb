class Devise::RegistrationsController < DeviseController

  def new
    resource = build_resource({})
    respond_with resource
  end

  def create

    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      #raise resource.errors.messages.inspect
      email_error = resource.errors.messages[:email]
      password_error = resource.errors.messages[:password]

      if email_error && email_error.first == "can't be blank"
        flash[:error] = "Debe completar el campo Email."
      elsif email_error && email_error.first == "has already been taken"
        flash[:error] = "El email ya es usado por otra persona."
      elsif password_error && password_error.first == "is too short (minimum is 8 characters)"
        flash[:error] = "La contrasena debe tener al menos 8 caracteres."
      elsif password_error && password_error.first == "can't be blank"
      end
      clean_up_passwords resource
      respond_with resource
    end
  end

end