class SubSubCategory < ActiveRecord::Base
  attr_accessible :name, :key, :sub_category_id
  belongs_to :sub_category
end
