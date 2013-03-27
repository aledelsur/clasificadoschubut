class Category < ActiveRecord::Base
  attr_accessible :key, :name
  has_many :sub_categories

  def info
  {
    :name               => self.name,
    :sub_categories     => self.sub_categories,
  }
  end

end
