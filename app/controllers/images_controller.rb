class ImagesController < ApplicationController

  # GET /uploads
  # GET /uploads.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    @image = Image.find(params[:id], :include => :publication)
    #@total_uploads = Image.find(:all, :conditions => { :publication_id => @image.publication.id})
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /uploads/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    raise params.inspect
      newparams = coerce(params)
      @image = Image.new(newparams[:image])
      if @image.save
        flash[:notice] = "Successfully created image."
        respond_to do |format|
          format.html {redirect_to @image.publication}
          format.json {render :json => { :result => 'success', :image => image_path(@image) } }
        end
      else
        render :action => 'new'
      end
    end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def coerce(params)
    if params[:image].nil? 
      h = Hash.new 
      h[:image] = Hash.new 
      h[:image][:publication_id] = params[:publication_id] 
      h[:image][:image] = params[:Filedata] 
      h[:image][:image].content_type = MIME::Types.type_for(h[:image][:image].original_filename).to_s
      h
    else 
      params
    end 
  end

  
end
