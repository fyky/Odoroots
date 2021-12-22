class ApplicationController < ActionController::Base
  # ログインする前にもアクセス可能なページ
  # before_action :authenticate_user!,except: [:top]

  
  #ログイン認証の前
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # before_action :user_state, only: [:create, :user_state]
  # protected

  # # 退会されているかを判断するメソッド
  # def user_state
  #   @user = User.find_by(email: params[:user][:email])
  #   return if !@user
  #   if @user.valid_password?(params[:user][:password]) && @user.is_deleted
  #     flash[:alert] = "退会済みのアカウントです"
  #     redirect_to new_user_registration_path
  #   end
  # end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :real_name, :postal_code, :address, :address_detail, :phone_number, :birthday, :gender, :is_deleted])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      user_path(resource)
    end
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end
end
