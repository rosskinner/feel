class MoodsController < ApplicationController

  def index
    @mood = Mood.new
  end

  def new
    @mood = Mood.new
  end

  def create
    @mood = Mood.new mood_params

    @tweet_count[0].each do |t|
      @t1= t[0]
      @t2 = t[1]
    end
    if @mood.save
      @mood << @mood.mood
      redirect_to locations_path
    else
      render :new
    end
    raise params.inspect
  end

  def show
    @location = Location.find params[:id]
  end



  private
    def mood_params
      params.require(:mood).permit(:mood => @t1, :count => @t2)
    end
end