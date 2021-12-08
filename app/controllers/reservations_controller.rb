class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])

  end

  def confirm
  end

  def create
  end

  def complete
  end

  def index
  end
end
