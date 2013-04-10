class SubCategory < ActiveRecord::Base
  attr_accessible :category_id, :key, :name
  has_many :sub_sub_categories
  belongs_to :category

  def info
  {
    :name           => self.name,
    :category_name  => self.category.name,
  }
  end

end
