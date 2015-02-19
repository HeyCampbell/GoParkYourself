class SpotsController < ApplicationController
  def create
    spot = Spot.create(latitude: params['latitude'], longitude: params['longitude'], user: current_user )
    spot_info = {spot: spot, suspended: Tweet.suspended?, regs: spot.regs, park_right_now: spot.park_now?, move_by: spot.park_till}
    render json: spot_info.to_json
  end

  def show

  end

  def update
     p params
     spot = Spot.find(params[:id])
     spot.regs

    if params[:active] == "false"
      spot.active = false
    elsif params[:remind?] == "true"
      if spot.park_till[0][:side] == params[:side_of_street]
        expiration = spot.park_till[0][:i_can_park_until]
      else
        expiration = spot.park_till[1][:i_can_park_until]
      end
        spot.update_attributes(remind?:  true, expiration: expiration)
        Message.send_text_message({number_to_send_to: "+1" + params[:phone_number].delete(" ").delete(".").delete("-"), body: "Reminder set. Please remember to move your vehicle by #{expiration}. We'll send you a heads up an hour before"})
    else
      spot.update_attributes(remind?: false)
    end
      redirect_to map_url
  end

  def deactivate
    spot = Spot.find(params[:id])
    spot.active = false
    redirect_to map_url
  end


end
