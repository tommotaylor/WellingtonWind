# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ForecastIO.configure do |configuration|
      configuration.api_key = '709a6c5b8ebe5c5467512ded06436d39'
    end