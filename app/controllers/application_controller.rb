class ApplicationController < ActionController::Base
  # ログインする前にもアクセス可能なページ
  before_action :authenticate_user!,except: [:top]
  
  #ログイン認証の前
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :real_name, :postal_code, :address, :address_detail, :phone_number, :birthday, :gender, :is_deleted])
  end

  def after_sign_in_path_for(resource)
    user_path(@user)
  end

  def after_sign_up_path_for(resource)
    user_path(@user)
  end

end
