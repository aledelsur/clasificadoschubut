ActiveAdmin.register Option do

  actions :index, :edit, :destroy, :update

  #Eliminar filters
  config.clear_sidebar_sections!

  index do
    column :key
    default_actions
  end

  controller do
  end
  
end