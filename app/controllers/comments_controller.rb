class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = current_user.comments.new(comment_params)
    @comment.event_id = @event.id
    @comment.save
    # 通知
    @event.create_notification_comment!(current_user, @comment.id)
    # ここまで
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

end
