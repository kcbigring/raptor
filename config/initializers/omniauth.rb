OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider  :facebook, '441434542606779', 'e801f79bdfc9a3dcfbcb75bd71827049',
            :scope => 'user_photos'
end