class Publication < ActiveRecord::Base
  


  #scope :quit_incomplete_publications, lambda{where("title <> ?", nil)}  
  
  attr_accessible :title, :description, :city_id, :sub_category_id, :price, :i_am, :currency, :email, :phone,
     :brand, :model, :year, :condition, :km, :color, :fuel, :sold, :type, :status, :urgent, :sub_sub_category_id, :user_id, :has_title

  #validates_presence_of :title, :if => :active_or_details?
  #validates_presence_of :title
  #validates :title, :presence => { :message => "Campo requerido." }, :if => :active_or_details?
  #validates :currency, :presence => { :message => "Campo requerido." }, :if => :active_or_details?
  #validates :price, :presence => { :message => "Campo requerido." }, :if => :active_or_details?
  #validates :description, :presence => { :message => "Campo requerido." }, :if => :active_or_details?

  belongs_to :sub_category
  belongs_to :sub_sub_category
  belongs_to :city
  belongs_to :user
  
  has_many :images, :dependent => :destroy

  #validates_presence_of :title, :description, :price, :i_am, :currency, :email, :condition

  define_index do
    indexes title
    indexes description
    #indexes city_id
    #indexes sub_category_id

    has city_id, sub_category_id, has_title, sold
    
    set_property :delta => true
  end  

  def info
  {
    :title                => self.title,
    :description          => self.description,
    :price                => self.price,
    :currency             => self.currency,
    :created_at           => self.created_at,
    :status               => self.status,
    :urgent               => self.urgent,
    :city                 => self.city.name,
    :brand                => self.brand,
    :model                => self.model,
    :year                 => self.year,
    :km                   => self.km,
    :fuel                 => self.fuel,
    :color                => self.color,
    :type                 => self.type,
    :i_am                 => self.i_am,
    :condition            => self.condition,
    :user_name            => user_name,
    :user_email           => user_email,
    :phone                => self.phone,
    :sub_category         => subcategory,    
    :sub_sub_category     => sub_sub_category,
  }
  end

    #:first_image          => self.images.first if self.images,

  ###############
  ############## make sure you have a database index on the type column

  def self.last_publications # Only articles with title and not sold are shown
    Publication.where("has_title = ? AND sold = ?", true, false).order("created_at DESC").limit(10)
  end

  def has_subcategory?
    !self.sub_sub_category.nil?
  end

  def active_or_details?
    unless status.nil?
      if (status == "details" || status == "active")
        return true
      end
    end
  end

  def user_name
    user.name if user
  end

  def user_email
    user.email if user
  end

  def subcategory
    sub_category.name if sub_category
  end

  def sub_sub_category
    self.sub_category.name if self.sub_category
  end


  # def set_urgency
  #   if urgent == true
  #     "Vendo urgente"
  #   end
  # end

end
