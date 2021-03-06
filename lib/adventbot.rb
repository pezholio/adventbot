require 'date'
require 'twitter'
require 'dotenv'

Dotenv.load

class Adventbot

  CHRISTMAS = Date.new(Date.today.year, 12, 25)

  def self.tweet
    return if Date.today.month != 12
    return if Date.today > CHRISTMAS

    days = (CHRISTMAS - Date.today).to_i

    if days == 0
      tweet = "Merry Christmas!!"
    elsif days == 1
      tweet = "Just one day to go until Christmas! How exciting!"
    else
      tweet = "There are #{days} days to go until Christmas!"
    end

    image = "#{days}.jpg"
    pic = File.join(File.dirname(__FILE__), "images", image)

    twitter.update(tweet)
    twitter.update_profile_image(File.new(pic))
  end

  def self.twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_KEY']
      config.access_token_secret = ENV['ACCESS_SECRET']
    end
  end

end
