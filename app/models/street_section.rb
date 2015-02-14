class StreetSection < ActiveRecord::Base
  has_many :signs, :foreign_key => 'status_order', :primary_key => 'status_order'
  before_save :geocode_from, :geocode_to

  def borough_name
    case borough
    when "M"
      return "New York"
    when "B"
      return "Bronx"
    when "K"
      return "Brooklyn"
    when "Q"
      return "Queens"
    end
  end

  def geocode_from
    data = Geocoder.search("#{main_street} and #{from_street}, #{borough_name}, New York")[0]
    if data
      self.latitude_from = data.data["geometry"]["location"]["lat"]
      self.longitude_from = data.data["geometry"]["location"]["lng"]
    end
  end

  def geocode_to
    data = Geocoder.search("#{main_street} and #{to_street}, #{borough_name}, New York")[0]
    if data
      self.latitude_to = data.data["geometry"]["location"]["lat"]
      self.longitude_to = data.data["geometry"]["location"]["lng"]
    end
  end

end
