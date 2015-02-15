class Tweet < ActiveRecord::Base

  def self.pull_and_save_tweet
      client = Twitter::REST::Client.new do |config|
       config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
       config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
       config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
       config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']

      end

      tweet = Tweet.new(created: client.user_timeline("nycasp").first.created_at, content: client.user_timeline("nycasp").first.text)

      tweet.save! if ( (tweet.created + 36000 >= Time.now) && (tweet.created != Tweet.last.created) )
  end

end