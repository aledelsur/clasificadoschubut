class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :search, :show_one_publication]
  before_filter :site_values

  def index
    @categories = Category.all
    @cities = City.all
    @last_publications = Publication.all
    #@publication = Publication.new

    session[:subcategory_visited] = nil
    session[:city_visited] = nil
    session[:keyword_search] = nil
  end


  ### THINKING SPHINX DOCUMENTATION AND EXAMPLES ###
  ### http://pat.github.io/thinking-sphinx/searching.html#conditions

  def search
    @event = params[:event]
    @categories = Category.all #must be here because it is used in both events
    @all_cities = City.all #must be here because it is used in both events

    if @event == "search_by_textfield"
      #MULTIPLE SEARCHES http://stackoverflow.com/questions/1273479/multiple-keyword-search-using-thinking-sphinx-rails-plugin
      @keyword_search = params[:search][:words]
      @publications = Publication.search @keyword_search
      session[:keyword_search] = @keyword_search
    elsif @event == "search_by_city"
      @city = City.where(:key => params[:city]).first

      add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
      
      @keyword_search = session[:keyword_search]

      session[:city_visited] = @city.id
      (session[:subcategory_visited] && params[:index] == "true") ? session[:subcategory_visited] = nil : ""

      if session[:subcategory_visited]
        sub_category = SubCategory.find(session[:subcategory_visited])
        add_breadcrumb sub_category.category.name, "#"
        add_breadcrumb sub_category.name, "#"
      end

      if @keyword_search
        @publications = Publication.search @keyword_search, :with => {:city_id => @city.id}
        @in_city = true
      elsif sub_category # When first select a sub category in the index page, and then change the city on the left
        @publications = Publication.search :with => {:city_id => @city.id, :sub_category_id => sub_category.id}
      else # When first select a city in the index page
        @publications = Publication.search :with => {:city_id => @city.id}
      end

    elsif @event == "search_by_subcategory"
      @city = City.find(session[:city_visited]) if session[:city_visited]

      sub_category = SubCategory.find(params[:id])

      if @city # When first select a city in the index page, and then change the categories on the left
        @publications = Publication.search :with => {:sub_category_id => params[:id], :city_id => @city.id}
      else # When first select a sub category in the index page
        @publications = Publication.search :with => {:sub_category_id => params[:id]}
      end

      session[:subcategory_visited] = sub_category.id
      if @city 
        add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
        session[:subcategory_visited] = nil
      end
      add_breadcrumb sub_category.category.name, "#"
      add_breadcrumb sub_category.name, "#"
    end
    flash[:warning] = "Te recordamos que Chubut Clasificados es una p&aacute;gina nueva. Pronto encontrar&aacute;s lo que est&aacute;s buscando!" if @publications.empty?
    render "show_publications"
  end

  def show_one_publication
    @publication = Publication.find(params[:id])
    render :layout => "show_publication"
  end

  def contact
  end

  def send_contact_email
    ClasificadosMailer.contact(params).deliver
    flash[:notice] = "Gracias por tu consulta! Te responderemos a la brevedad."
    redirect_to root_path
  end

  def oauth_failure
    #THIS ACTIONS IS DOING NOTHING. NEVER ENTERS HERE. I could delete it, but I won't do it because
    # in the initializer omniauth.rb I am calling this action. If I put this action in the :except
    # of AuthenticateUser! it also never entering here.
    redirect_to root_path
  end
  
end
