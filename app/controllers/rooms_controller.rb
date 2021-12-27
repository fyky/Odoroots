class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create(:name => "DM")
    @join_current_user = RoomUser.create(user_id: current_user.id, room_id: @room.id)
    @join_user = RoomUser.create(join_room_params)

      # 通知ここから
      @room_member_not_me=RoomUser.where(room_id: @room.id).where.not(user_id: current_user.id)
      @the_id=@room_member_not_me.find_by(room_id: @room.id)
      notification = current_user.active_notifications.new(
        room_id: @room.id,
        room_id: @room.id,
        visited_id: @the_id.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )

      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
          notification.checked = true
      end
      notification.save if notification.valid?

      # ここまで

    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if RoomUser.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
      @message = Message.new
      @room_users = @room.room_users.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @user = current_user
    @rooms = @user.room_users.order(updated_at: :desc)
    @user_room_user=RoomUser.where(user_id: @user.id)
  end

 private

 def join_room_params
   params.require(:room_user).permit(:user_id, :room_id).merge(room_id: @room.id)
 end

end
