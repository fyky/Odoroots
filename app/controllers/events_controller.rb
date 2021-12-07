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
      # save できなかったら :new へ
      unless @event.save
        render :new
      end
    end
  end

  def create
    # event_id を取り出してから publish を true に変更
    Event.find(params[:event][:id].to_i).update(publish: true)
    redirect_to event_path
  end

  def index
  end

  def show
    if params[:id] = 'confirm'
      redirect_to new_event_path and return
    end
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
