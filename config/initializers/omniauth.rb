OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '255692991232366', '22f485c50790dc166ad9ea448b46eafd'
end