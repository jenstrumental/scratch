Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], :scope => "email"
   #, :client_options => {:ssl => {:ca_path => "C:\devkit\cacert.pem"}}
end
