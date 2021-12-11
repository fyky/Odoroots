class FavoritesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.new(event_id: event.id)
    favorite.save
    # 通知
    event.create_notification_favorite!(current_user)
    # ここまで
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.find_by(event_id: event.id)
    favorite.destroy
    redirect_to event_path(event)

  end






end
