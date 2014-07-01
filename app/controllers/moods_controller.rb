class MoodsController < ApplicationController

  def new
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "IvtR98I8pUhsRv2aoDrhtkXTi"
      config.consumer_secret     = "dKNsuFZOKA9ysxfYmEBh0wnF4ezBk8nYxjQvVXSeHtXXn0UrGJ"
      config.access_token        = "2497635019-T4FsRE3oHHDZu4Hq2B3QzsgIH154yC6F18xSDwV"
      config.access_token_secret = "293BVRX1izmQ4kcOiDUykehtZCvh9nz9l3iq2n3T620bl"
    end

    @locations = @current_user.locations
    @long = $place.first
    @lat = $place.last
    @mood = @client.search('happy', :geocode => "#{@long},#{@lat},1mi")
  end
end