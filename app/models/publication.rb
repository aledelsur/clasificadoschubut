class Publication < ActiveRecord::Base
  
  
  attr_accessible :title, :description, :city_id, :sub_category_id, :price, :i_am, :currency, :email, :phone,
     :brand, :model, :year, :condition, :km, :color, :fuel, :sold, :type, :status, :urgent, :sub_sub_category_id, :user_id

  #validates_presence_of :title

  belongs_to :sub_category
  belongs_to :city
  belongs_to :user
  
  has_many :images

  define_index do
    indexes title#, :sortable => true
    indexes description
    #indexes city_id
    #indexes sub_category_id

    has city_id, sub_category_id
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
    :type                 => self.type,
    :km                   => self.km,
    :i_am                 => self.i_am,
    #:first_image          => self.images.first if self.images,

  }
  end

  ###############
  ############## make sure you have a database index on the type column

  # def set_urgency
  #   if urgent == true
  #     "Vendo urgente"
  #   end
  # end

end
