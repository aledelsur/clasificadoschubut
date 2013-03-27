class SubCategory < ActiveRecord::Base
  attr_accessible :category_id, :key, :name
  belongs_to :category

  def info
  {
    :name     => self.name,
  }
  end

end
