if Rails.env == 'production' or Rails.env == 'staging'
  # Set credentials from ENV hash (Heroku)
  REDISTOGO_URL = ENV['REDISTOGO_URL']
  REDISTOGO_HOST = URI.parse(REDISTOGO_URL).host
  REDISTOGO_PORT = URI.parse(REDISTOGO_URL).port
  REDISTOGO_PASSWORD = URI.parse(REDISTOGO_URL).password
  $redis = Redis.new(:host => REDISTOGO_HOST, :port => REDISTOGO_PORT, :password => REDISTOGO_PASSWORD)
else
  # Get credentials from YML file
  REDISTOGO_URL = 'redis://localhost:6379/'
  REDISTOGO_HOST = URI.parse(REDISTOGO_URL).host
  REDISTOGO_PORT = URI.parse(REDISTOGO_URL).port
  $redis = Redis.new(:host => REDISTOGO_HOST, :port => REDISTOGO_PORT)
end
