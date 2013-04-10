class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :application_values

  add_breadcrumb "Inicio", :root_path

  def application_values
    @user = current_user
    ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
  end

  def site_values

  end

  # def omniauth_failure
  #   redirect_to init_sign_in_users_path
  #   #redirect wherever you want.
  # end  

end
