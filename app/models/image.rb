class Image < ActiveRecord::Base
  attr_accessible :image, :publication_id

  belongs_to :publication

  has_attached_file :image, 
  :styles => { :small => "170x200#", :home =>"784x260#"}, :default_url => "missing.jpg"#, :content_type => { :content_type => "image/jpg" }
end

end
