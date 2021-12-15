class EventsController < ApplicationController
  def new
    if params[:id]
      @event = Event.find(params[:id])
    else
      @event = Event.new
    end
  end

  def confirm
    if params[:event][:id]
      # もし params[:event][:id] があれば、データを探してアップデート
      @event = Event.find(params[:event][:id].to_i)

      @event.update(event_params)
    else
      @event = Event.new(event_params)
      @event.user_id = current_user.id
      # save できなかったら :new へ
      unless @event.save
        render :new
      end
    end
  end

  def create
    @event = Event.find(params[:event][:id].to_i)
    # event_id を取り出してから publish を true に変更
    # @event.user_id = current_user.id
    @event.update(publish: true)
    redirect_to event_path(@event.id)
  end

  def index
    @allevents = Event.published.order(created_at: :desc)
    #.page(pamars[:page])でページネーションを追加
    @events = @allevents.page(params[:page]).per(9)

  end

  def show
    # if params[:id] = 'confirm'
    #   redirect_to new_event_path and return
    # end
    @event = Event.find(params[:id])
    @reservations = Reservation.where(event_id: @event)
    @comment = Comment.new

    @attendreservations = Reservation.where(event_id: @event, permission:"done")
    @attend = current_user.reservations.find_by(event_id: @event, permission:"done")
    # if @reservations.permission == "yet"
    # @reservations.update(permission: "done")
    # end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.user_id = current_user.id
    @reservations = Reservation.where(event_id: @event)

    if @event.update(event_params)
      # if @reservations.event.recruitment.count == @event.number.count
      # 現在のイベントで、「未承認」のものが存在していなかったら
      # unless @reservations.find_by(event_id: @event, permission: "yet").present?
        # 予約の「承認」数が、イベントの募集人数と同じだったら
        if @reservations.where(permission: "done").count == @event.number
          # 「承認」された予約のイベント
          @event.update(recruitment: false)
          # @reservations.find_by(event_id: @event, permission: "done").event.update(recruitment: false)
        else
          @event.update(recruitment: true)
          # @reservations.find_by(event_id: @event, permission: "done").event.update(recruitment: true)
        end
      # end



      # Event.published.where(['deadline < ?', Date.current]).update_all(recruitment: true)

      # else
      redirect_to event_path(@event)
    end

  end

  def search
    @allevents = Event.published.search(params[:keyword]).order(created_at: :desc)
    @events = @allevents.page(params[:page]).per(9)

    @keyword = params[:keyword]
    render "index"
  end


  # ストロングパラメータ
  private
  def event_params
    params.require(:event).permit(
      :name, :image,
      :address, :address_detail,
      :date, :start_time, :end_time,
      :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention,
      :number, :longitude, :latitude
      )
  end

end
