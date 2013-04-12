class ClasificadosMailer < ActionMailer::Base

  default from: "no-responder@from.com"

  def change_password(params=nil)
    name_or_email = !params[:user][:first_name].nil? ? params[:user][:first_name] : params[:user][:email]
    mail(:to => params[:user][:email], :subject => "Cambio de contrasena - Chubut Clasificados", :body => "Hola #{name_or_email}, te escribimos para recordarte que has modificado tu contrasena correctamente.")
  end

  def contact(params=nil)
    mail(:to => "alealvarez.00@gmail.com", :subject => "#{params[:name]} (#{params[:email]}) nos hizo una consulta - Chubut Clasificados", :body => params[:question])
  end


end