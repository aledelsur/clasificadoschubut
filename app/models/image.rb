class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :publication

  has_attached_file :image, 
  :styles => { :small => "170x200#", :home =>"784x260#"},
    :storage => :s3,
    :bucket => "clasificadoschubut",
    :s3_options     => {
    :server => "s3-website-us-east-1.amazonaws.com"},
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "/#{Rails.env}/publication_steps/:attachment/:style/:id/:filename"

end
