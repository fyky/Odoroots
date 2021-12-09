class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = @user.events
    @reservations = @user.reservations
    @attends = @reservations.where(permission: "done")
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
    @events = current_user.events
  end

  def attend
  end


  private
    def user_params
      params.require(:user).permit(:name, :address, :address_detail, :phone_number, :genre, :image, :introduction)
    end

end
