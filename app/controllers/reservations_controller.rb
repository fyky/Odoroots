class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @event = Event.find(params[:event_id])
    @reservation.user_id = current_user.id
  end

  def confirm
    @reservation = Reservation.new(reservation_params)

    # @reservation = Reservation.find(params[:id])
    @event = Event.find(params[:event_id])
    if @event.invalid? #入力項目に空のものがあれば入力画面に遷移
      render :new
    end

    # binding.irb
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to complete_event_reservations_path
    else
      render :new

    end
  end

  def complete
  end

  def index
  end


  private
    def reservation_params
      params.require(:reservation).permit(:comment, :user_id, :event_id)
    end

end
