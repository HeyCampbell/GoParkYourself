class SpotsController < ApplicationController
  def create
    spot = Spot.create(latitude: params['latitude'], longitude: params['longitude'])
    spot_info = {spot: spot, suspended: Tweet.suspended?, regs: spot.get_signs.map do |k,v|
        {side: k , rules: v[0].no_parking_times}
      end
    }

    p spot_info

    render json: spot_info.to_json

  end
end
