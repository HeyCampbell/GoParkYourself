class WelcomesController < ApplicationController
  def index
    redirect_to action: :user if current_user
  end

  def user
    if current_user.spots.last
      redirect_to action: :map unless current_user.spots.last.active
    end
  end

  def map

  end

end
