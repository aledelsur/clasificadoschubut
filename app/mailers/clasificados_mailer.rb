class ClasificadosMailer < ActionMailer::Base

  default from: "no-responder@from.com"


  def change_password(params=nil)
    attachments['logo.png'] = File.read(File.join(Rails.root,'app','assets','images','logo.png'))
    name_or_email = !params[:user][:first_name].nil? ? params[:user][:first_name] : params[:user][:email]
    mail(:to => params[:user][:email], :subject => "Cambio de contrasena - Chubut Clasificados", :body => "Hola #{name_or_email}, te escribimos para recordarte que has modificado tu contrasena correctamente.")
  end

  def contact(params=nil)
    attachments['logo.png'] = File.read(File.join(Rails.root,'app','assets','images','logo.png'))
    mail(:to => "alealvarez.00@gmail.com", :subject => "#{params[:name]} (#{params[:email]}) nos hizo una consulta - Chubut Clasificados", :body => params[:question])
  end

  def contact_seller(params=nil)
    attachments['logo.png'] = File.read(File.join(Rails.root,'app','assets','images','logo.png'))
    mail(:to => params[:owner_product_email], :subject => "#{params[:name]} te hizo una consulta en Chubut Clasificados", :body => params[:question])
  end

end