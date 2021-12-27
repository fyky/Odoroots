class FavoritesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    favorite = current_user.favorites.new(event_id: @event.id)
    favorite.save
    # 通知
    @event.create_notification_favorite!(current_user)
    # ここまで
  end

  def destroy
    @event = Event.find(params[:event_id])
    favorite = current_user.favorites.find_by(event_id: @event.id)
    favorite.destroy

  end

  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id)
  end






end
