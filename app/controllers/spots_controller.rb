class SpotsController < ApplicationController
  def create
    spot = Spot.create!(latitude: params['latitude'], longitude: params['longitude'])
    p spot.latitude
    p spot
    # if @spot.save
    #   # @signs = @spot.street_section.signs.all
    render json: spot.to_json
    # else
    #   return "You've made a terrible mistake"
    # end
  end


  # def spot_params
  #   params.require(:spot).permit(:latitude, :longitude)
  # end

end
