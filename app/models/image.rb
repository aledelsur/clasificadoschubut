class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :publication

  has_attached_file :image, 
    :styles => {
      :small => "170x200#",
      :big   => "400x400#"
    }
end
