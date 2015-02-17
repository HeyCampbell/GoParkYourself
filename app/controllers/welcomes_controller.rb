class WelcomesController < ApplicationController
  def index
    redirect_to action: :user if current_user
  end

  def user
    if current_user.spots.last
      @spot = current_user.spots.last
    else
      redirect_to action: :map
    end
  end

  def map

  end

end
