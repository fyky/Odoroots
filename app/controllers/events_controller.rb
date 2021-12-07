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
    @events = Event.published
  end

  def show
    # if params[:id] = 'confirm'
    #   redirect_to new_event_path and return
    # end
    @event = Event.find(params[:id])
  end

  def edit
  end


  # ストロングパラメータ
  private
  def event_params
    params.require(:event).permit(
      :name, :image,
      :address, :address_detail,
      :date, :start_time, :end_time,
      :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention
      )
  end

end