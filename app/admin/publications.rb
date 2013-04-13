ActiveAdmin.register Publication do
  
  actions :index, :edit, :update, :destroy
  filter :title

  menu :label => "Publicaciones"


  index do
    column "Titulo" do |publication|
      publication.title
    end
    column "Usuario" do |publication|
      publication.user.email
    end
    default_actions
  end

end
