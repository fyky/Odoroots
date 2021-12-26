class HomesController < ApplicationController
  before_action :authenticate_user!,except: [:top, :about]

  def top
    @genres = Genre.all
  end
end
