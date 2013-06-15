class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :search, :order, :show_one_publication, :contact, :send_contact_email, :autocomplete]
  before_filter :site_values

  def index
    @categories = Category.all
    @cities = City.all
    @last_publications = Publication.last_publications

    session[:subcategory_visited] = nil
    session[:city_visited] = nil
    session[:keyword_search] = nil
    session[:in_city] = nil
  end


  ### THINKING SPHINX DOCUMENTATION AND EXAMPLES ###
  ### http://pat.github.io/thinking-sphinx/searching.html#conditions

  def search
    @event = params[:event]
    @categories = Category.all #must be here because it is used in both events
    @all_cities = City.all #must be here because it is used in both events

    if @event == "search_by_textfield"
      @keyword_search = params[:search][:words]
      publications = Publication.search @keyword_search
      session[:keyword_search] = @keyword_search
      session[:search_made] = @keyword_search
      #@size_res = publications.length
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
        publications = Publication.search @keyword_search, :with => {:city_id => @city.id}, :without=> {:has_title => 0, :sold => 1} #don't give if product is sold
        session[:city_id] = @city.id
        @in_city = true
        session[:in_city] = true
      elsif sub_category # When first select a sub category in the index page, and then change the city on the left
        publications = Publication.search :with => {:city_id => @city.id, :sub_category_id => sub_category.id}, :without=> {:has_title => 0, :sold => 1} #don't give if product is sold
        session[:city_id] = @city.id
        session[:subcategory_id] = sub_category.id
        session[:search_made] = {:city_id => @city.id, :sub_category_id => sub_category.id}
      else # When first select a city in the index page
        publications = Publication.search :with => {:city_id => @city.id}, :without=> {:has_title => 0, :sold => 1} #don't give if product is sold)
        session[:city_id] = @city.id
        session[:search_made] = {:city_id => @city.id}
      end

    elsif @event == "search_by_subcategory"
      @city = City.find(session[:city_visited]) if session[:city_visited]

      sub_category = SubCategory.find(params[:id])

      if @city # When first select a city in the index page, and then change the categories on the left
        publications = Publication.search :with => {:sub_category_id => params[:id], :city_id => @city.id}, :without=> {:has_title => 0, :sold => 1} #don't give if product is sold
        session[:search_made] = {:city_id => @city.id, :sub_category_id => params[:id]}
      else # When first select a sub category in the index page
        publications = Publication.search :with => {:sub_category_id => params[:id]}, :without=> {:has_title => 0, :sold => 1} #don't give if product is sold
        session[:search_made] = {:sub_category_id => params[:id]}
      end

      session[:subcategory_visited] = sub_category.id
      if @city 
        add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
        session[:subcategory_visited] = nil
      end
      add_breadcrumb sub_category.category.name, "#"
      add_breadcrumb sub_category.name, "#"
    end
    #### Session params for order later
    session[:event] = @event
    session[:index] = params[:index]
    session[:subcategory_visited] = sub_category.id if sub_category
    ####

    
    @publications = publications.page(params[:page]).per(2)
    flash[:warning] = "Te recordamos que Chubut Clasificados es una p&aacute;gina nueva. Pronto encontrar&aacute;s lo que est&aacute;s buscando!" if @publications.empty?
    render "show_publications"
  end

  def order
    
    if params[:sort] == "less-price"
      if session[:search_made].is_a?(String) #Is a keyword search
        if session[:in_city] # if viewing the results filtered by city: Resultados para "los" en "Trelew"
          publications = (Publication.search session[:search_made], :with=>{:city_id => session[:city_visited]}).sort {|a, b| a.price <=> b.price}
        else
          publications = (Publication.search session[:search_made]).sort {|a, b| a.price <=> b.price}        
        end
      else #Is a search by city or category
        publications = Publication.search(:with => session[:search_made], :without=> {:has_title => 0, :sold => 1}).sort {|a, b| a.price <=> b.price}
      end
      @less_price = true
    elsif params[:sort] == "high-price"
      if session[:search_made].is_a?(String) #Is a keyword search
        if session[:in_city]
          publications = (Publication.search session[:search_made], :with=>{:city_id => session[:city_visited]}).sort {|a, b| b.price <=> a.price}
        else
          publications = (Publication.search session[:search_made]).sort {|a, b| b.price <=> a.price}  
        end
      else #Is a search by city or category
        publications = Publication.search(:with => session[:search_made], :without=> {:has_title => 0, :sold => 1}).sort {|a, b| b.price <=> a.price}
      end
      @high_price = true
    elsif params[:sort] == "date"
      if session[:search_made].is_a?(String) #Is a keyword search
        if session[:in_city]
          publications = (Publication.search session[:search_made], :with=>{:city_id => session[:city_visited]}).sort {|a, b| b.created_at <=> a.created_at}
        else
          publications = (Publication.search session[:search_made]).sort {|a, b| b.created_at <=> a.created_at}
        end  
      else #Is a search by city or category
        publications = Publication.search(:with => session[:search_made], :without=> {:has_title => 0, :sold => 1}).sort {|a, b| b.created_at <=> a.created_at}
      end
      @date = true
    end
    
    
    #### Load default variables
    @categories = Category.all #must be here because it is used in both events
    @all_cities = City.all #must be here because it is used in both events
    @event = session[:event]
    params[:index] = session[:index]
    sub_category = SubCategory.find session[:subcategory_visited] if session[:subcategory_visited]
    @keyword_search = session[:search_made] if session[:search_made].is_a?(String) #Is a keyword search
    @size_res = publications.size
    if @event == "search_by_city"
      @in_city = session[:in_city]
      @city = City.find session[:city_visited]
    end
    ####

    unless session[:search_made].is_a?(String) # If the search is not a keyword search
      #### breadcrumbs
      if @event == "search_by_city"

        @city = City.find session[:search_made][:city_id]
        add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
        
        if session[:subcategory_visited]
          sub_category = SubCategory.find(session[:subcategory_visited])
          add_breadcrumb sub_category.category.name, "#"
          add_breadcrumb sub_category.name, "#"
        end

      elsif @event == "search_by_subcategory"
        @city = City.find(session[:search_made][:city_id]) if session[:search_made][:city_id]
        if @city 
          add_breadcrumb @city.name, search_path(:event => "search_by_city", :city => @city.key, :index=>true)
        end
        add_breadcrumb sub_category.category.name, "#"
        add_breadcrumb sub_category.name, "#"

      end
      #### finish breadcrumbs
    end

    @publications = Kaminari.paginate_array(publications).page(params[:page]).per(2)
    render "show_publications"

  end

  def autocomplete
    @publications = Publication.search "*"+params[:str]+"*"
  end

  def contact
  end

  def send_contact_email
    if params[:to] == "seller"
      publication = Publication.find params[:publication_id]
      params[:owner_product_email] = publication.email
      ClasificadosMailer.contact_seller(params).deliver
      flash[:notice] = "Tu consulta fu&eacute; enviada correctamente."
      redirect_to publication_path(publication)
    else
      ClasificadosMailer.contact(params).deliver
      flash[:notice] = "Gracias por tu consulta! Te responderemos a la brevedad."
      redirect_to root_path
    end
  end

  def oauth_failure
    #THIS ACTIONS IS DOING NOTHING. NEVER ENTERS HERE. I could delete it, but I won't do it because
    # in the initializer omniauth.rb I am calling this action. If I put this action in the :except
    # of AuthenticateUser! it also never entering here.
    redirect_to root_path
  end
  
end
