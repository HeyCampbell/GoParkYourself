class SpotsController < ApplicationController
  def create
    spot = Spot.create(latitude: params['latitude'], longitude: params['longitude'])


    spot_info = {spot: spot, suspended: Tweet.suspended?, regs: spot.regs}

    p spot_info

    render json: spot_info.to_json

  end
end
