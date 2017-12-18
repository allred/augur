require 'twitter'

class TwitterClient
  attr_accessor :client

  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] || 'jZFm6u2gUshTozg8VRdLtNq3M'
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end
  end
end
