ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :address, :address_detail, :date, :start_time, :end_time, :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention, :image_id, :publish, :user_id, :genre_id, :number, :recruitment, :latitude, :longitude
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :address_detail, :date, :start_time, :end_time, :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention, :image_id, :publish, :user_id, :genre_id, :number, :recruitment, :latitude, :longitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  ActiveAdmin.register Event do
    permit_params :name, :image, :genre_id,
      :address, :address_detail,
      :date, :start_time, :end_time,
      :introduction, :requirement, :deadline, :belongings, :meeting_place, :attention,
      :number, :longitude, :latitude
  end

end
