class SpotsController < ApplicationController
  def create
    # raise params.inspect
    # @response = params
    # p params
    render json: {lat: params['latitude'], lng: params['longitude']}
  end
end
