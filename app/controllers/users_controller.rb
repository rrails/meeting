class UsersController < ApplicationController
  # around_filter :time_zone, :only => :edit

  def time_zone(user, &block)
    Time.use_zone(user.timezone, &block)
  end

  def index
    @users = User.all
    # binding.pry

  end

  def new
    @user = User.new
  end

  def create
    user = User.create(params[:user])
    # Convert times from user timezone to UTC
    Time.zone = params[:user][:timezone]
    user.preferredstarttime = Time.use_zone(Time.zone) {Time.zone.parse(params[:user][:preferredstarttime]).in_time_zone(Time.zone)}
    user.preferredendtime = Time.use_zone(Time.zone) {Time.zone.parse(params[:user][:preferredendtime]).in_time_zone(Time.zone)}
    user.save

    redirect_to(user)
  end

  def show
    @user = User.find(params[:id])
    @user.preferredstarttime = @user.preferredstarttime.in_time_zone(@user.timezone)
    @user.preferredendtime = @user.preferredendtime.in_time_zone(@user.timezone)
  end

  def edit
    @user = User.find(params[:id])
    @user.preferredstarttime = @user.preferredstarttime.in_time_zone(@user.timezone)
    @user.preferredendtime = @user.preferredendtime.in_time_zone(@user.timezone)
  end

  def update
    user = User.find(params[:id]) #find the user we want to update
    # convert the time from user timezone to UTC
    Time.zone = params[:user][:timezone]
    user.preferredstarttime = Time.use_zone(Time.zone) {Time.zone.parse(params[:user][:preferredstarttime]).in_time_zone(Time.zone)}
    user.preferredendtime = Time.use_zone(Time.zone) {Time.zone.parse(params[:user][:preferredendtime]).in_time_zone(Time.zone)}
    user.save

    user.update_attributes(params[:user])
    redirect_to(users_path)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to(users_path)
  end

end