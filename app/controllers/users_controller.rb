class UsersController < ApplicationController

  before_action :check_if_logged_in, :except => [:new, :create]
  before_action :check_if_admin, :only => [:index]


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @location = Location.new
    @locations = @user.locations

  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user = User.find params[:id]
    user.update(user_params)
    redirect_to user_path
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :avatar, :password, :password_confirmation)
    end

    def check_if_logged_in
      redirect_to(new_user_path) if @current_user.nil?
    end

    def check_if_admin
      redirect_to(root_path) unless @current_user.is_admin?
    end
end

