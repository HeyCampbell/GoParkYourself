class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
    user.update(phone_number: params[:phone_number].delete(" "))
    if user.save
      spot = user.spots.last
      spot.regs
      if spot.park_till[0][:side] == params[:side_of_street]
        expiration = spot.park_till[0][:i_can_park_until]
      else
        expiration = spot.park_till[1][:i_can_park_until]
      end
      spot.update(remind?:  true, expiration: expiration)
      Message.send_text_message({number_to_send_to: "+1" + params[:phone_number].delete(" ").delete(".").delete("-"), body: "Reminder set. Please remember to move your vehicle by #{expiration}. We'll send you a heads up an hour before"})
      
    end
    redirect_to user_home_path
  end
end
