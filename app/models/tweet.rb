class Tweet < ActiveRecord::Base

THREE_HOURS = 10800
TEN_HOURS = 36000
EIGHT_AM = 8

  def self.pull_and_save

    client = Twitter::REST::Client.new do |config|
     config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
     config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
     config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
     config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']

    end

    tweet = Tweet.create(created: client.user_timeline("nycasp").first.created_at - THREE_HOURS, content: client.user_timeline("nycasp").first.text)

    if /suspended today/.match(tweet.content)
      tweet.update(suspended?: true)
    else
      tweet.update(suspended?: false)
    end
  end

  def self.suspended?

    if (!Tweet.any? || Tweet.last.created.day < Time.now.day && Time.now.hour > EIGHT_AM)
      Tweet.pull_and_save
    end
    Tweet.last.suspended?
  end

end
