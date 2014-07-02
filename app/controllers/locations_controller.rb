class LocationsController < ApplicationController

  before_action :check_if_logged_in

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    @place = Geocoder.coordinates(@location.place)
    @location.long = @place.first
    @location.lat = @place.last
    if @location.save
      @current_user.locations << @location

      # raise params.inspect

      redirect_to locations_path
    else
      # raise params.inspect
      render :new

    end
  end

  def index
    @location = Location.new
    @locations = @current_user.locations
    # raise params.inspect
  end

  def show
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "IvtR98I8pUhsRv2aoDrhtkXTi"
      config.consumer_secret     = "dKNsuFZOKA9ysxfYmEBh0wnF4ezBk8nYxjQvVXSeHtXXn0UrGJ"
      config.access_token        = "2497635019-T4FsRE3oHHDZu4Hq2B3QzsgIH154yC6F18xSDwV"
      config.access_token_secret = "293BVRX1izmQ4kcOiDUykehtZCvh9nz9l3iq2n3T620bl"
    end

    @location = Location.find params[:id]
    @mood = @client.search('excited', :geocode => "#{@location.long},#{@location.lat},#{@location.radius}km")

    # raise params.inspect

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
    end
    redirect_to locations_path
  end

  def destroy
    location = Location.find params[:id]
    location.destroy
    redirect_to locations_path
  end


  private
    def location_params
      params.require(:location).permit(:place, :radius, :user_id, :long, :lat)
    end

    def check_if_logged_in
      redirect_to(login_path) if @current_user.nil?
    end
end