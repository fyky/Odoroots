class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    @events = @user.events.published.order(created_at: :desc).limit(3)
    @reservations = @user.reservations
    @attends = @reservations.where(permission: "done").order(created_at: :desc).limit(3)

  unless current_user == nil
      @current_user_room_user=RoomUser.where(user_id: current_user.id)

    @user_room_user=RoomUser.where(user_id: @user.id)
    # もしuseridが現在のユーザーじゃなかったら
    unless @user.id == current_user.id
      @current_user_room_user.each do |cu|
        @user_room_user.each do |u|
          # ルームIDの特定
          if cu.room_id == u.room_id then
            @have_room = true
            @room_id = cu.room_id
          end
        end
      end
      unless @have_room    #ルームが同じじゃなければ
        #新しいインスタンスを生成
        @room = Room.new
        @RoomUser = RoomUser.new
        #//新しいインスタンスを生成
      end
    end
  end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path
    else
      flash[:alert] = "ユーザー情報を更新できませんでした"
      render :edit
    end
  end

  def unsubscribe
  end

  def host
    @events = current_user.events.published.order(created_at: :desc)
  end

  def attend
    @user = User.find(params[:id])
    @events = @user.events.published
    @reservations = @user.reservations
    @attends = @reservations.where(permission: "done").order(created_at: :desc)
  end


  private
    def user_params
      params.require(:user).permit(:name, :address, :address_detail, :phone_number, :genre, :image, :introduction,
                                   :twitter, :instagram, :facebook, :youtube)
    end

end
