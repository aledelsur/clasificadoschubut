#http://blog.yangtheman.com/2012/02/09/facebook-connect-with-rails-omniauth-devise/

Rails.application.config.middleware.use OmniAuth::Builder do
 # The following is for facebook
   provider :facebook, "615270258487238", "a0393230a7ff017fbc8d230b3fe9d567", {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
 
 # If you want to also configure for additional login services, they would be configured here.


  OmniAuth.config.on_failure = SiteController.action(:oauth_failure)

end