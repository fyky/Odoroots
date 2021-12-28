ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :real_name, :postal_code, :address, :address_detail, :phone_number, :birthday, :gender, :image_id, :introduction, :dance_genre, :is_deleted, :genre, :twitter, :instagram, :facebook, :youtube
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :real_name, :postal_code, :address, :address_detail, :phone_number, :birthday, :gender, :image_id, :introduction, :dance_genre, :is_deleted, :genre, :twitter, :instagram, :facebook, :youtube]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ActiveAdmin.register User do
    permit_params :name, :address, :address_detail, :phone_number, :genre, :image, :introduction,
                  :twitter, :instagram, :facebook, :youtube, :postal_code
  end

end
