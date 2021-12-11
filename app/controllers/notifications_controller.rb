class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(is_checked: false).each do |notification|
      notification.update_attributes(is_checked: true)
    end
  end



end
