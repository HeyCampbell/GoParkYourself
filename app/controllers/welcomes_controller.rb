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

  def user_current_spot
    if current_user.spots.last
      spot = current_user.spots.last
      spot_info = {spot: spot, suspended: Tweet.suspended?, regs: spot.regs}
      render json: spot_info.to_json
    end
  end

  def map

  end

end
