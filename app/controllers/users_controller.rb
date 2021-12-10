class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = @user.events.order(created_at: :desc).limit(3)
    @reservations = @user.reservations
    @attends = @reservations.where(permission: "done").order(created_at: :desc).limit(3)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path
  end

  def unsubscribe
  end

  def host
    @events = current_user.events.order(created_at: :desc)
  end

  def attend
    @user = User.find(params[:id])
    @events = @user.events
    @reservations = @user.reservations
    @attends = @reservations.where(permission: "done").order(created_at: :desc)
  end


  private
    def user_params
      params.require(:user).permit(:name, :address, :address_detail, :phone_number, :genre, :image, :introduction)
    end

end
