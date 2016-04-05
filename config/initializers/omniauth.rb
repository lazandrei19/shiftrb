Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "77jbkngl2499j4", "3nsInGjTIpVODEPn", :scope => 'r_emailaddress r_basicprofile', :fields => ['id', 'email-address', 'first-name', 'last-name', 'headline', 'picture-urls::(original)', 'public-profile-url', 'api-standard-profile-request', 'three-past-positions']
end