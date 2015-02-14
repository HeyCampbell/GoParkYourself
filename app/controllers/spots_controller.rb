class SpotsController < ApplicationController
  def create
    spot = Spot.create!(latitude: params['latitude'], longitude: params['longitude'])

    spot_info = {spot: spot, regs: spot.effective_sign.no_parking_times}

    # if @spot.save
    #   # @signs = @spot.street_section.signs.all
    render json: spot_info.to_json
    # else
    #   return "You've made a terrible mistake"
    # end
  end



  # def spot_params
  #   params.require(:spot).permit(:latitude, :longitude)
  # end

end
