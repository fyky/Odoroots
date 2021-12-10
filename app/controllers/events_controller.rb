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
    #.page(pamars[:page])でページネーションを追加
    @events = Event.published.page(params[:page]).per(9)
  end

  def show
    # if params[:id] = 'confirm'
    #   redirect_to new_event_path and return
    # end
    @event = Event.find(params[:id])

    @reservations = Reservation.where(event_id: @event)

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
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "You have updated user successfully."
    end

  end

  def search
    @events = Event.published.search(params[:keyword]).page(params[:page]).per(9)
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
      :number
      )
  end

end
