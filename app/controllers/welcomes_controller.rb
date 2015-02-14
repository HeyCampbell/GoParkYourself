class WelcomesController < ApplicationController
  def index
    redirect_to action: :map if current_user
  end

  def map

  end

end
