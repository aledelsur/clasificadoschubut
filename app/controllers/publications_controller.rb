class PublicationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout 'new_publication'

  def index
    @my_publications = Publication.where('user_id = ?', @user.id)
    render :layout => "my_account"
  end

  def edit
    @publication = Publication.find(params[:id])
    @sub_category = @publication.sub_category
    this_year = Date.today.year
    @years = (this_year-100..this_year).sort {|a,b| b <=> a}

    @brands = case @sub_category.key 
        when "autos_y_camionetas" then CarBrand.all
        when "camiones_y_colectivos" then TruckBrand.all
        when "motos_y_cuatriciclos" then MotoBrand.all
        end
    @nautica_sub_categories = @sub_category.sub_sub_categories if @sub_category.key == "nautica"
    render :layout => "my_account"
  end

  def show
    @publication = Publication.find(params[:id])
    render :layout => "show_publication"
  end

  def update
    raise "Params: publications_controller "+params.inspect
    publication = Publication.find(params[:id])
    publication.update_attributes(params[:publication])
    if publication.save
      flash[:notice] = "Los datos fueron actualizados correctamente."
      redirect_to publications_path
    else
      flash[:error] = "Hay un problema"
      render :edit
    end
  end


  def create
    @publication = Publication.new(params[:publication])
    #params[:product][:status] = 'active' if step == steps.last
    if @publication.save
      session[:publication_id] = @publication.id
      redirect_to publication_steps_path
    else
      render :new
    end    
  end

  def new
    @publication = Publication.new
    #@publication = Publication.new(:include => :publication)
    @cities = City.all
    @current_step = "cities"
    #@image = Image.find(params[:id], :include => :publication)
  end


  def destroy
    @publication = Publication.find params[:id]
    if @publication.destroy
      flash[:notice] = "La publicaci&oacute;n se ha eliminado correctamente."
    else
      flash[:error] = "Ha ocurrido un error."
    end
    redirect_to publications_path
  end

  def mark_as_sold
    @publication = Publication.find params[:id]
    if params[:option] == "do" 
      @publication.sold = true
      @message = "El producto se ha marcado como vendido."
    else
      @publication.sold = false
      @message = "El producto se ha vuelto a publicar."
    end
    @publication.save
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
    raise "multifile_publication_images_upload"
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
