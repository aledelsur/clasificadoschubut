class PublicationsController < ApplicationController
  layout 'new_publication'

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
  end

end
