class Tweet < ActiveRecord::Base

  def self.pull_and_save

    client = Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
     config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
     config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
     config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']

    end

    tweet = Tweet.create(created: client.user_timeline("nycasp").first.created_at, content: client.user_timeline("nycasp").first.text)
    if ( (/suspended today/.match(tweet.content)) || (/suspended tomorrow/.match(tweet.content)) )
      tweet.update(suspended?: true)
    else
      tweet.update(suspended?: false)
    end
  end

  def self.suspended?
    if Tweet.last.created + 36000 <= Time.zone.now
      Tweet.pull_and_save
    end
    Tweet.last.suspended?
  end
end
