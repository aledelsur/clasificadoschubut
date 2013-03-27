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
    @publication.attributes = params[:publication]
    render_wizard @publication
  end    

end
