class UsersController < ApplicationController

  def update
    user = User.find(params[:id])
     user.update(phone_number: params[:phone_number].delete(" "))

    user.save ? return true : return false
  end

end