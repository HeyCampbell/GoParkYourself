class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
     user.update(phone_number: params[:phone_number].delete(" "))
     #set spot to remind, set expiration based on info passed

  if user.save
    user.spots.last.update(remind?:  true, expiration: )
# send to user page
  else
# kick back, not a valid number
  end

  end

end