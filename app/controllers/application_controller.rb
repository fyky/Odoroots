class ApplicationController < ActionController::Base
  #ログイン認証の前
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :real_name, :postal_code, :address, :address_detail, :phone_number, :birthday, :gender, :is_deleted])
  end

end
