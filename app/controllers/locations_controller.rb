class LocationsController < ApplicationController

  before_action :check_if_logged_in

  def new
    @location = Location.new
  end

  def index
    @location = Location.new
    @locations = @current_user.locations
  end

  def show
    @location = Location.find (params[:id])
    @moods = @location.moods.take(3)
    @time = @location.created_at

  end

  def create
    @location = Location.new location_params

    @place = Geocoder.coordinates(@location.place)
    @location.long = @place.first
    @location.lat = @place.last

    if @location.save
      @current_user.locations << @location
      @tweet_count = get_moods @location.id
      @tweet_count.each do |t|
        mood = Mood.create(:mood => t[0], :count => t[1])
        @location.moods << mood
      end

      redirect_to locations_path
    else
      render :new
    end
  end

  def edit
    @location = Location.find params[:id]
    render :edit

  end

  def update
    @location = Location.find params[:id]
    @location.update(location_params)
    @place = Geocoder.coordinates(@location.place)
    @location.long = @place.first
    @location.lat = @place.last
    if @location.save
      @current_user.locations << @location
      @tweet_count = get_moods @location.id
      @tweet_count.each do |t|
        mood = Mood.create(:mood => t[0], :count => t[1])
        @location.moods << mood
      end
    end
    redirect_to locations_path
  end

  def destroy
    location = Location.find params[:id]
    location.destroy
    redirect_to locations_path
  end


  private
  def get_moods(id)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "IvtR98I8pUhsRv2aoDrhtkXTi"
      config.consumer_secret     = "dKNsuFZOKA9ysxfYmEBh0wnF4ezBk8nYxjQvVXSeHtXXn0UrGJ"
      config.access_token        = "2497635019-T4FsRE3oHHDZu4Hq2B3QzsgIH154yC6F18xSDwV"
      config.access_token_secret = "293BVRX1izmQ4kcOiDUykehtZCvh9nz9l3iq2n3T620bl"
    end

    @location = Location.find id

    @positive_mood = "happy OR excited OR pumped OR loved OR wonderful OR blessed OR great OR determined OR awesome OR amused OR hopeful OR proud OR special OR relaxed OR good OR accomplished OR better OR free"

    @pos_array = @positive_mood.split " OR "

    @negative_mood = "sad OR angry OR pissed OR tired OR annoyed OR meh OR sick OR bored OR sleepy OR irritated OR confused OR down OR depressed OR exhausted OR alone OR lost OR hungry OR lonely OR bad OR cold OR curious OR sorry OR scared"

    @neg_array = @negative_mood.split " OR "

    @positive_tweets = @client.search(@positive_mood, :geocode => "#{@location.long},#{@location.lat},#{@location.radius}km")
    @negative_tweets = @client.search(@nagative_mood, :geocode => "#{@location.long},#{@location.lat},#{@location.radius}km")

    @pos_count = {}
    @positive_tweets.entries.each do |tweet|
      @pos_array.each do |word|
        if tweet.full_text.index word
          @pos_count[word] ||= 0
          @pos_count[word] += 1
        end
      end
    end

    @neg_count = {}
    @negative_tweets.entries.each do |tweet|
      @neg_array.each do |word|
        if tweet.full_text.index word
          @neg_count[word] ||= 0
          @neg_count[word] += 1
        end
      end
    end

    @tweet_count = @neg_count.merge@pos_count
    @tweet_count = @tweet_count.sort_by{|k,v| v}.reverse.take(3)
  end

  def location_params
    params.require(:location).permit(:place, :radius, :user_id, :long, :lat)
  end

  def check_if_logged_in
    redirect_to(login_path) if @current_user.nil?
  end
end