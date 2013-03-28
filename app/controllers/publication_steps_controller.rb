class PublicationStepsController < ApplicationController
  layout 'new_publication'
  
  include Wicked::Wizard
  steps :category, :details
  
  def show
    @publication = Publication.find(session[:publication_id])
    @categories = Category.all
    render_wizard
  end

  def update
    @publication = Publication.find(session[:publication_id])

    raise current_step.inspect
    category = SubCategory.where(:id=>params[:publication][:sub_category_id]).first.category
    params[:publication][:type] = case category.key
      when "compra_venta" then "CompraVentaPublication"
      when "inmuebles" then "InmueblesPublication"
      when "vehiculos_y_accesorios" then "VehiculosPublication"
      when "empleo" then "EmpleosPublication"
      when "viajes_y_turismo" then "ViajesTurismoPublication"
      when "cursos_y_talleres" then "CursosTalleresPublication"
      when "servicios" then "ServiciosPublication"
      end
    @publication.attributes = params[:publication]
    render_wizard @publication
  end    

end
