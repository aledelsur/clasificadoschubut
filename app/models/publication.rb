class Publication < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  #scope :quit_incomplete_publications, lambda{where("title <> ?", nil)}  
  
  attr_accessible :title, :description, :city_id, :sub_category_id, :sub_subcategory_manual, :price, :i_am, :currency, :email, :phone,
     :brand, :car_brand_id, :moto_brand_id, :truck_brand_id, :model, :year, :condition, :km, :color, :fuel, :sold, :type, :status, :urgent, :sub_sub_category_id, :user_id, :has_title

  validates_presence_of :title, :if => :active_or_details?
  validates_presence_of :price, :if => :active_or_details?
  validates_presence_of :description, :if => :active_or_details?
  validates_presence_of :email, :if => :active_or_details?
  validates_presence_of :condition, :if => :active_or_details?

  belongs_to :sub_category
  belongs_to :sub_sub_category
  belongs_to :car_brand
  belongs_to :moto_brand
  belongs_to :truck_brand
  belongs_to :city
  belongs_to :user
  
  has_many :images, :dependent => :destroy

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
    :brand                => set_brand,
    :model                => self.model,
    :year                 => self.year,
    :km                   => self.km,
    :fuel                 => self.fuel,
    :color                => self.color,
    :type                 => self.type,
    :i_am                 => self.i_am.capitalize,
    :condition            => self.condition.capitalize,
    :user_name            => self.user.name,
    :user_email           => self.user.email,
    :phone                => self.phone,
    :sub_category         => subcategory,    
    :sub_subcategory     => sub_subcategory,
  }
  end

    #:first_image          => self.images.first if self.images,

  ###############
  ############## make sure you have a database index on the type column


  def self.last_publications # Only articles with title and not sold are shown
    Publication.where("has_title = ? AND sold = ?", true, false).order("created_at DESC").limit(10)
  end

  def has_subcategory?
    self.sub_category.key == "nautica"
  end

  def set_brand
    if self.car_brand
      self.car_brand.name
    elsif self.moto_brand
      self.moto_brand.name
    elsif self.truck_brand
      self.truck_brand.name
    else
      self.brand
    end
  end

  def sub_subcategory
    #self.sub_category.name if self.sub_category
    #raise self.sub_subcategory_manual.inspect
    if self.sub_sub_category
      self.sub_sub_category.name
    else
      self.sub_subcategory_manual
    end
  end

  def active_or_details?
    unless status.nil?
      if (status == "details" || status == "active")
        return true
      end
    end
  end

  def subcategory
    sub_category.name if sub_category
  end




  # def set_urgency
  #   if urgent == true
  #     "Vendo urgente"
  #   end
  # end

end
