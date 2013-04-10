class UsersController < ApplicationController
  
  def edit
    render "edit", :layout => "my_account"
  end

  def update
    if params[:event] == "basic_info"
      user = User.find(params[:id])
      user.update_attributes(params[:user])
      if user.save
        flash[:notice] = "Tus datos fueron modificados correctamente."
        redirect_to root_path
      else
        flash[:error] = "Hay un problema"
        render :edit
      end
    elsif params[:event] == "change_password"
      user = User.find(params[:id])
      if user.valid_password?(params[:user][:current_password])
        user.update_attributes(params[:user])
        if user.update_with_password(params[:user])
          sign_in(user, :bypass => true)
        end
        flash[:notice] = "Tus datos fueron modificados correctamente."
        ClasificadosMailer.change_password(:user=>@user).deliver
        redirect_to root_path
      else
        # encoding: UTF-8
        flash[:error] = "Tu contrasena actual no es correcta o las contrasenas nuevas no coinciden ."
        render :action => 'edit'
      end    
    end
  end
  

  def update_password
    user = User.find(params[:id])
    if user.update_attributes(params[:user][:current_password])
      if current_user.update_with_password(params[:user])
        sign_in(current_user, :bypass => true)
      end
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      #flash[:error] = "La contraseña actual no es correcta."
      render :action => 'edit'
    end    
  end

end