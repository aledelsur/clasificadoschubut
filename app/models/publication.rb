class Publication < ActiveRecord::Base
  
  
  attr_accessible :title, :description, :city_id, :sub_category_id, :price, :i_am, :currency, :email, :phone,
     :brand, :model, :year, :condition, :km, :color, :fuel, :sold, :type, :status, :urgent

  belongs_to :sub_category
  belongs_to :city
  has_many :images

  define_index do
    indexes title#, :sortable => true
    indexes description
    indexes city_id
    indexes sub_category_id

    has created_at, updated_at
  end  

  def info
  {
    :title                => self.title,
    :description          => self.description,
    :price                => self.price,
    :currency             => self.currency,
    #:first_image          => self.images.first if self.images,

  }
  end

  ###############
  ############## make sure you have a database index on the type column


end
