class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :search]
  before_filter :site_values

  def index
    @categories = Category.all
    @cities = City.all
    @last_publications = Publication.all
    @publication = Publication.new

    session[:subcategory_visited] = nil
    session[:city_visited] = nil
  end


  def search
    @event = params[:event]
    @categories = Category.all #must be here because it is used in both events
    @all_cities = City.all #must be here because it is used in both events

    if @event == "search_by_textfield"
      @publications = Publication.search params[:search][:words]
    elsif @event == "search_by_city"
      @city = City.where(:key => params[:city]).first
      @publications = Publication.search @city.id
      

      add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
      
      session[:city_visited] = @city.id
      (session[:subcategory_visited] && params[:index] == "true") ? session[:subcategory_visited] = nil : ""


      if session[:subcategory_visited]
        sub_category = SubCategory.find(session[:subcategory_visited])
        add_breadcrumb sub_category.category.name, "#"
        add_breadcrumb sub_category.name, "#"
      end

    elsif @event == "search_by_subcategory"
      @city = City.find(session[:city_visited]) if session[:city_visited]
      sub_category = SubCategory.find(params[:id])
      @publications = Publication.search params[:id]
      

      session[:subcategory_visited] = sub_category.id
      if @city 
        add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
        session[:subcategory_visited] = nil
      end
      add_breadcrumb sub_category.category.name, "#"
      add_breadcrumb sub_category.name, "#"
    end
    flash[:error] = "No hemos encontrado resultados." if @publications.empty?
    render "show_publications"
  end



  
end
