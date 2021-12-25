class EventsController < ApplicationController
  # ログインする前にもアクセス可能なページ、コントローラ
  before_action :authenticate_user!,except: [:index, :show, :search]
  before_action :correct_event,only: [:edit]

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
    if @event.update(publish: true)
      flash[:notice] = "イベントを投稿しました"
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "イベントを投稿できませんでした"
    end
  end

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])

      @allevents = @genre.events.published.order(created_at: :desc)
    else
      @allevents = Event.published.order(created_at: :desc)
    end
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
    @user = current_user
    # &.user

    @attendreservations = Reservation.where(event_id: @event, permission:"done")
    unless @user == nil
      @attend = @user.reservations.find_by(event_id: @event, permission:"done")
    end
    # if @reservations.permission == "yet"
    # @reservations.update(permission: "done")
    # end
  end

  def edit
    @event = Event.find(params[:id])
    if @event.date < Date.current
      flash[:alert] = "終了したイベントのため編集できません"
      redirect_to event_path(@event)
    end
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
      flash[:notice] = "イベントを更新しました"
      redirect_to event_path(@event)

    else
      flash[:alert] = "イベントを更新できませんでした"
      render :edit
    end

  end

  def search
    @genres = Genre.all
    # keyword = params[:keyword]
    # type = params[:type]
    # @records = search(keyword, type)

    keywords = params[:keyword].split(/[[:blank:]]+/)

    # p '---------'
    # p keywords

    # @allevents = []
    # keywords.each do |keyword|
    #   @allevents += Event.published.search(params[:keyword], params[:type]).order(created_at: :desc)
    # end

    # @allevents = Event.published.search(params[:keyword], params[:type]).order(created_at: :desc)

    @allevents = Event.published.order(created_at: :desc)
    # binding.irb
    if params[:type] == 'all'
      keywords.each do |keyword|
        @allevents = @allevents.where(["name LIKE ? OR address LIKE ?", "%#{keyword}%", "%#{keyword}%"])
      end
    else
      keywords.each do |keyword|
        @allevents = @allevents.where(["date > ? AND (name LIKE ? OR address LIKE ?)", Date.current, "%#{keyword}%", "%#{keyword}%"])
      end
    end


    @events = @allevents.page(params[:page]).per(9)

    # @keyword = params[:keyword]


    # @allevents = Event.published.search(params[:keyword]).order(created_at: :desc)

    @keyword = params[:keyword]
    # render "index"

    #開催前のみを表示
    # @not_end_event = Event.published.where(['date > ?', Date.current])
    #これをラジオボタンで実装したい
    render "index"


  end

  #なに？
  def correct_event
    @event = Event.find(params[:id])
    unless @event.user == current_user
      redirect_to event_path(@event)
    end
  end


  # ストロングパラメータ
  private
  def event_params
    params.require(:event).permit(
      :name, :image, :genre_id,
      :address, :address_detail,
      :date, :start_time, :end_time,
      :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention,
      :number, :longitude, :latitude
      )
  end

  # def search_for(keyword, method)

  #     if method == 'before'
  #       Event.published.where(['date > ?', Date.current])
  #     end

  #     if method == 'all'
  #       Event.published.all
  #     end

  # end


end
