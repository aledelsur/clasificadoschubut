class Image < ActiveRecord::Base
  attr_accessible :image, :publication_id

  belongs_to :publication

  has_attached_file :image, 
  :styles => { :small => "170x200#", :home =>"784x260#"}

end
