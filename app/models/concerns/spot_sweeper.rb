module SpotSweeper

  def sweep!
    format_spots_for_texts(get_hatching_spots).each do |formatted_spot|
      Message.send_text_message(formatted_spot)
    end
  end

  def get_active_spots
    Spot.where(active: true).where(reminder: true)
  end

  def get_hatching_spots
    spots_to_be_sent_reminders_now = []
    get_active_spots.each do |spot|
      if spot.expiration - Time.now < 3600
        spots_to_be_sent_reminders_now < spot
      end
    end
    spots_to_be_sent_reminders_now
  end

  def format_spots_for_texts(spots)
    formatted_spots = []
    spots.each do |spot|
      spot = Hash.new
      spot[:body] = "Hi there #{spot.user.name}! Please move your vehicle before parking expires at #{spot.expiration}"
      spot[:number] = "+1#{user.number}"
      formatted_spots << spot
    end
    formatted_spots
  end




end