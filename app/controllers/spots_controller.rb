class SpotsController < ApplicationController
  def create
    @spot = Spot.new(latitude: params['latitude'], longitude: params['longitude'])
    if @spot.save
      @signs = @spot.street_section.signs.all
      return @signs.json
    else
      return "You've made a terrible mistake"
    end
  end


  def spot_params
    params.require(:spot).permit(:latitude, :longitude)
  end

end
