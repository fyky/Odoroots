class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if RoomUser.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      # 通知
      @room=@message.room
      # ここまでを追加

      # ここから
        @room_member_not_me=RoomUser.where(room_id: @room.id).where.not(user_id: current_user.id)
        @the_id=@room_member_not_me.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
            room_id: @room.id,
            message_id: @message.id,
            visited_id: @the_id.user_id,
            visitor_id: current_user.id,
            action: 'dm'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?

      # ここまでを追加

      redirect_to room_path(@message.room_id)
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
    end
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :room_id, :body).merge(user_id: current_user.id)
    end

end
