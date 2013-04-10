class PublicationsController < ApplicationController
  before_filter :authenticate_user!
  

  def index
    @my_publications = Publication.where('user_id = ?', @user.id)
    render "index", :layout => "my_account"
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
    render "edit", :layout => "my_account"
  end

  def update
    raise params.inspect
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
    if @publication.save
      session[:publication_id] = @publication.id
      redirect_to publication_steps_path
    else
      render :new
    end    
  end

  def new
    @publication = Publication.new
    @cities = City.all
    @current_step = "cities"
    render "new", :layout => 'new_publication'
  end

end
