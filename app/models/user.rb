class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :authentications, :dependent => :delete_all
  has_many :publications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  attr_accessor :current_password
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :remember_me, :address, :phone, :provider, :uid, :oauth_token, :avatar
  # attr_accessible :title, :body

  validates_uniqueness_of    :email,     :case_sensitive => false, :allow_blank => true
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_confirmation_of   :password, :on=>:create, :if => lambda{|u| u.provider.nil?}
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true, :if => lambda{|u| u.provider.nil?}




  # def apply_omniauth(omniauth)
  #   authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  # end

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

  def self.picture_from_url(url)
    avatar = open(url)
  end  

  def logged_with_social?
    !self.authentications.empty?
  end

private

  # def skip_confirmation
  #   raise "Raise en User skip_confirmation NEW"+self.authentication.provider.inspect
  #   if self.provider
  #     self.skip_confirmation!
  #   end
  # end

end
