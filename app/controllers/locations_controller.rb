class LocationsController < ApplicationController

  before_action :check_if_logged_in

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    if @location.save
      redirect_to location_path(@location)
    else
    render :new
    end
  end

  def show
      @location = Location.find params[:id]
      @place = Geocoder.search(@location.place, :params => {:countrycodes => "AU"})

       raise params.inspect
  end

  def destroy
  end

  private
    def location_params
      params.require(:location).permit(:place, :radius, :user_id)
    end

    def check_if_logged_in
      redirect_to(login_path) if @current_user.nil?
    end
end