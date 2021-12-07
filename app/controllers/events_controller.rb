class EventsController < ApplicationController
  def new
    @event = Event.new

  end

  def confirm
    @event = Event.new(event_params)
    return if @event.invalid?
    render :new
  end

  def create
    event = Event.new(event_params)
    event.save
    redirect_to root_path
  end

  def index
  end

  def show
  end

  def edit
  end

  private
  def event_params
    params.require(:event).permit(:name)
  end


end
