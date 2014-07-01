class LocationsController < ApplicationController

  before_action :check_if_logged_in

  def new
    @location = Location.new
  end

  def create
    $location = Location.new location_params
    if $location.save
      @current_user.locations << $location
      redirect_to locations_path
    else
      raise params.inspect
      render :new
    end
  end

  def index
    $location = Location.new
    $locations = @current_user.locations
  end

  def show
    $location = Location.find params[:id]
    $place = Geocoder.coordinates($location.place)
  end

  def edit
    $location = Location.find params[:id]
    $place = Geocoder.coordinates($location.place)
    render :edit

  end

  def update
    $location = Location.find params[:id]
    $location.update(location_params)
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