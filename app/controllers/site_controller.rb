class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :search, :userss]
  before_filter :site_values

  def index
    @categories = Category.all
    @cities = City.all
    @last_publications = Publication.all
    #add_breadcrumb "index", index_path
  end


  def search

    @event = params[:event]
    @categories = Category.all
    if @event == "search_by_textfield"
      @publications = Publication.search params[:search][:words]
    elsif @event == "search_by_city"
      @city = City.where(:key => params[:city]).first
      add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key)
      @publications = Publication.search @city.id
      @categories = Category.all
      #raise breadcrumbs.inspect
    elsif @event == "search_by_subcategory"
      sub_category = SubCategory.find(params[:id])
      @publications = Publication.search params[:id]
      add_breadcrumb sub_category.category.name, search_path(:event => "search_by_subcategory", :id => sub_category.id)
      add_breadcrumb sub_category.name, search_path(:event => "search_by_subcategory", :id => sub_category.id)
    end
    render "show_publications"
  end

  def method_name
    
  end
  
end
