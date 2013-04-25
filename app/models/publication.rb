class Publication < ActiveRecord::Base
  
  
  attr_accessible :title, :description, :city_id, :sub_category_id, :price, :i_am, :currency, :email, :phone,
     :brand, :model, :year, :condition, :km, :color, :fuel, :sold, :type, :status, :urgent, :sub_sub_category_id, :user_id

  #validates_presence_of :title

  belongs_to :sub_category
  belongs_to :sub_sub_category
  belongs_to :city
  belongs_to :user
  
  has_many :images, :dependent => :destroy

  #validates_presence_of :title, :description, :price, :i_am, :currency, :email, :condition

  define_index do
    indexes title, :sortable => true
    indexes description
    #indexes city_id
    #indexes sub_category_id

    has city_id, sub_category_id
    
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
    :fuel                 => self.fuel.capitalize,
    :color                => self.color,
    :type                 => self.type,
    :i_am                 => self.i_am.capitalize,
    :condition            => self.condition.capitalize,
    :user_name            => self.user.name,
    :user_email           => self.user.email,
    :phone                => self.phone,
    :sub_category         => self.sub_category.name,
    :sub_sub_category     => self.sub_sub_category.name,
    #:first_image          => self.images.first if self.images,

  }
  end


  def self.last_publications
    Publication.all
  end

  def has_subcategory?
    !self.sub_sub_category.nil?
  end



  ###############
  ############## make sure you have a database index on the type column



  # def set_urgency
  #   if urgent == true
  #     "Vendo urgente"
  #   end
  # end

end
