module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    your_event = link_to 'あなたの投稿', event_path(notification), style:"font-weight: bold;"
    @visitor_comment = notification.comment_id
    #notification.actionがfollowかfavoriteかcommentかdmか
    case notification.action
      when "follow" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:event_path(notification.event_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visitor_comment)&.comment
          tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:event_path(notification.event_id), style:"font-weight: bold;")+"にコメントしました"
      when "dm" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたにDMを送りました"

    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(is_checked: false)
  end


end
