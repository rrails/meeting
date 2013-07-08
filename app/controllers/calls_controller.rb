class CallsController < ApplicationController
  def index
    @calls = Call.all
  end

  def new
    @call = Call.new
  end

  def create
    call = Call.create(params[:call])
    call.attendees.each do |attendee|
      attendee.meetingdate = call.date
      attendee.accepted = FALSE
      attendee.save
    end
    redirect_to(call)
  end

  def show
    @call = Call.find(params[:id])
  end

  def edit
    @call = Call.find(params[:id]) #find the call we want to update
  end

  def update
    call = Call.find(params[:id]) #find the call we want to update
    call.update_attributes(params[:call])
    redirect_to(call)
  end

  def destroy
    call = Call.find(params[:id])
    call.destroy
    redirect_to(calls_path)
  end

end