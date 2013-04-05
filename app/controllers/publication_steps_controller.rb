class PublicationStepsController < ApplicationController
  layout 'new_publication'
  
  include Wicked::Wizard
  steps :category, :details
  
  def show
    @publication = Publication.find(session[:publication_id])
    @city_selected_name = City.where(:id=>@publication.city_id).first.name
    if @publication.sub_category_id
      @sub_category = SubCategory.where(:id=>@publication.sub_category_id).first
    end

    #@sub_category.key == "autos_y_camionetas" ? 

    @categories = Category.all
    @current_step = "category" if params[:id] == "category"
    @current_step = "details" if params[:id] == "details"
    

    respond_to do |format|
      format.js { render_wizard }
      format.html {redirect_to root_path}
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

    if step == "details".to_sym
      params[:publication][:type] = session[:publication_type]
    end
    
       
    @publication.attributes = params[:publication]

    render_wizard @publication
  end    




  def upload_asset(params)
    file = params[:Filedata]
    mime_type = MIME::Types.type_for(file.original_filename).first
    file.content_type = "#{mime_type}"
    m = yield(file, mime_type)
    fkey = file.original_filename
    resp = {}
    if m.save
      resp[:id] = m.id.to_s
      resp[:url]= m.image.url(:small)
    else
      resp[:errors] = m.errors.messages
    end
    
    return resp
  end

  def multifile_publication_images_upload
    upload_asset params do |file, mime_type|
      image = Image.new(image: file, image_content_type: mime_type.to_s)
      image.image_content_type = mime_type.to_s
      image
    end
  end

  def multifile_upload
    publication = Publication.find(params[:publication_id])
    upload_asset params do |file, mime_type|
      image = Image.new(image: file, publication: publication, image_content_type: mime_type.to_s)
      image.image_content_type = mime_type.to_s
      image
    end
  end  


end

