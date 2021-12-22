class ReservationsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])

    if current_user == @event.user
      flash[:alert] = "あなたが主催したイベントであるため、予約できません。"
      redirect_to event_path(@event)
    elsif Reservation.find_by(event_id: @event.id, user_id: current_user.id).present?
      flash[:alert] = "すでに予約したイベントのため、予約できません。"
      redirect_to event_path(@event)
    elsif Reservation.find_by(date: @event.date, permission: "done")
      flash[:alert] = "重複した参加予定のイベントがあるため、予約できません。"
      redirect_to event_path(@event)
    elsif Reservation.find_by(date: @event.date, permission: "yet")
      flash[:alert] = "参加承認待ちのイベントがあるため、予約できません。"
      redirect_to event_path(@event)
    elsif Event.find_by(user_id: current_user.id, date: @event.date)
      flash[:alert] = "主催イベントの開催日ですので、予約できません。"
      redirect_to event_path(@event)
    else
      @reservation = Reservation.new
      @reservation.user_id = current_user.id
    end
    # @reservation.user_id = current_user.id
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @event = Event.find(params[:event_id])
    if @event.invalid? #入力項目に空のものがあれば入力画面に遷移
      render :new
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      # binding.irb
      redirect_to event_reservation_path(@event, @reservation)

    # 通知
    @event.create_notification_reservation!(current_user, @reservation.id)
    # ここまで

    else
      flash[:alert] = "イベントを予約できません。"
      render :new
    end
  end

  def show
    @event = Event.find(params[:event_id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
      if @reservation.permission == "done"
      # 通知
        @reservation.update_notification_permission!(current_user)
      # ここまで
      end

    @event = Event.find(params[:event_id])
    @reservations = Reservation.where(event_id: @event)

    if @reservations.where(permission: "done").count == @event.number
      @reservation.event.update(recruitment: false)
    else
      @reservation.event.update(recruitment: true)
    end
    redirect_to event_path(@event)
  end

  def index
    @user = current_user
    @reservations = @user.reservations.order(created_at: :desc)
  end

  def back
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new(reservation_params)
		render :new
  end


  private
    def reservation_params
      params.require(:reservation).permit(:comment, :user_id, :event_id, :permission, :date)
    end

end
