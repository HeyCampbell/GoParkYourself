class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
     user.update_attributes(phone_number: params[:phone_number].delete(" "))
     #set spot to remind, set expiration based on info passed

    if user.save

      user.spots.last.update_attributes(remind?:  true, expiration: user.spots.last.park_till)

      redirect_to user_url
    end
  end

end