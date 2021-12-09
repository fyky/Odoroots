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

      redirect_to event_reservation_path(@event, @reservation)
    else
      render :new

    end
  end

  def show
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    redirect_to reservations_path
  end

  def index
    @user = current_user
    @reservations = @user.reservations
  end


  private
    def reservation_params
      params.require(:reservation).permit(:comment, :user_id, :event_id, :permission)
    end

end
