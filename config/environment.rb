# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Libr::Application.initialize!

if Rails.env.development?
  # Rails.logger = Le.new('32df6983-8040-4c6b-b42b-508e490af4b5', debug: true)
else
  Rails.logger = Le.new('32df6983-8040-4c6b-b42b-508e490af4b5')
end
