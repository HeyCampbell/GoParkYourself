class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
     user.update_attributes(phone_number: params[:phone_number].delete(" "))
     #set spot to remind, set expiration based on info passed

    if user.save

      spot = user.spots.last
      spot.regs

      if spot.park_till[0][:side] == params[:side_of_street]
        expiration = spot.park_till[0][:i_can_park_until]

      else
        expiration = spot.park_till[1][:i_can_park_until]

      spot.update_attributes(remind?:  true, expiration: expiration)
      end

      redirect_to user_url
    end
  end

end