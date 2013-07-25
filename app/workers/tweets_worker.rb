# class TweetsWorker
#   include Sidekiq::Worker

#   def perform(article_id)
#   	article = Article.find(article_id)
#     authentication = Authentication.where(:provider => 'twitter').first

#     twitter_client = Twitter::Client.new(
#       :oauth_token => authentication.token,
#       :oauth_token_secret => authentication.secret
#     )
      
#     twitter_client.update('Please ignore this tweet..')
#   end
# end