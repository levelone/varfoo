OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'X330xlyxxHM79ZNMPEt7A',  'CcBrrgwshkfndhdXWip1muwELPWW8jaSX89dSB8SzE'
end