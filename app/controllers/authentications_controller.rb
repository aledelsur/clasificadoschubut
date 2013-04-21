 class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to authentications_url
    else
      user = User.new(:email => omniauth.info.email, :password => Devise.friendly_token[0,20], :name => omniauth.info.name, :avatar => User.picture_from_url(omniauth.info.image))
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user.skip_confirmation!
      user.save!
      sign_in_and_redirect(:user,user)
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  def failure
    redirect_to root_path
  end
 end
