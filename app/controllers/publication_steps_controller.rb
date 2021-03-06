class PublicationStepsController < ApplicationController
  before_filter :application_values
  layout 'new_publication'
  
  include Wicked::Wizard
  steps :category, :details
  
  def show
    @publication = Publication.find(session[:publication_id])
    if params[:back] # Only when I am in details step and goes back.
      @publication.city_id = params[:city_id]
    end
    @city_selected_name = City.where(:id=>@publication.city_id).first.name
    if @publication.sub_category_id
      @sub_category = SubCategory.where(:id=>@publication.sub_category_id).first
    end

    this_year = Date.today.year
    @years = (this_year-100..this_year).sort {|a,b| b <=> a}

    if @sub_category
      @brands = case @sub_category.key 
        when "autos_y_camionetas" then CarBrand.all
        when "camiones_y_colectivos" then TruckBrand.all
        when "motos_y_cuatriciclos" then MotoBrand.all
        end
      @nautica_sub_categories = @sub_category.sub_sub_categories if @sub_category.key == "nautica"
    end

    @categories = Category.all
    @current_step = "category" if params[:id] == "category"
    @current_step = "details" if params[:id] == "details"
    

    respond_to do |format|
      format.js { render_wizard }
      format.html {redirect_to publication_path(@publication)}
    end
  end

  def update

    @publication = Publication.find(session[:publication_id])
    @sub_category = @publication.sub_category_id ? SubCategory.where(:id=>@publication.sub_category_id).first : SubCategory.where(:id=>params[:publication][:sub_category_id]).first
    if step == "category".to_sym
      session[:publication_type] = case @sub_category.category.key
        when "compra_venta" then "CompraVentaPublication"
        when "inmuebles" then "InmueblesPublication"
        when "vehiculos_y_accesorios" then "VehiculosPublication"
        when "empleo" then "EmpleosPublication"
        when "viajes_y_turismo" then "ViajesTurismoPublication"
        when "cursos_y_talleres" then "CursosTalleresPublication"
        when "servicios" then "ServiciosPublication"
        end
    end
    params[:publication][:status] = step
    params[:publication][:status] = 'active' if step == steps.last

    if step == "details".to_sym # enters here only when button Finalizar is clicked
      params[:publication][:has_title] = true #set the product searchable, and avoid to brake the page when searching
      params[:publication][:type] = session[:publication_type]
      clear_specific_brand_if_necessary
      #clear_specific_sub_subcategory_if_necessary(params[:publication][:sub_subcategory_manual])
      clear_specific_sub_subcategory_if_necessary
    end
    

    @publication.attributes = params[:publication]
    render_wizard @publication
  end  

  def clear_specific_brand_if_necessary
    if params[:publication][:brand] != "" # Manual brand was entered
      params[:publication][:car_brand_id] = nil
      params[:publication][:moto_brand_id] = nil
      params[:publication][:truck_brand_id] = nil
    end
  end  

  def clear_specific_sub_subcategory_if_necessary
    if params[:publication][:sub_subcategory_manual] != ""
      params[:publication][:sub_sub_category_id] = nil
    end
  end








end

