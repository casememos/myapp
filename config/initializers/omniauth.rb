Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, 	'345611455538203', '28c172fef0d3495d040847204bdf68d4', {:scope => 'name, image, email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
 
  # If you want to also configure for additional login services, they would be configured here.
end
