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

  def geocode_from
    data = Geocoder.search("#{main_street} and #{from_street}, #{borough_name}, New York")[0]
    self.latitude_from = data.data["geometry"]["location"]["lat"]
    self.longitude_from = data.data["geometry"]["location"]["long"]
  end

  def geocode_to
    data = Geocoder.search("#{main_street} and #{to_street}, #{borough_name}, New York")[0]
    self.latitude_to = data.data["geometry"]["location"]["lat"]
    self.longitude_to = data.data["geometry"]["location"]["long"]
  end

  # def street_side(point) #point = [lat, long]
  #   start = [self.latitude_from, self.longitude_from]
  #   lat_diff = point[0] - start[0]
  #   long_diff = point[1] - point[1]
  #   # lat_diff > 1 ? point.street_side = "north" : "south"
  #   if lat_diff > 1
  #     point.street_side = "north"
  #   else if lat_diff < -1
  #     point.street_side ="south"
  #   else if long_diff > 1
  #     point.street_side = ""
  #   else
  #     point.street_side = ""
  # end
end