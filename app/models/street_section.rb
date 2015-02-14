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

  def self.get_distance_in_feet(point1, point2) #( [lat2, lng2], [lat1, lng1] )
    (Geocoder::Calculations.distance_between(point1, point2)*5280).to_i
  end

  def point_from
    [self.latitude_from, self.longitude_from]
  end

  def point_to
    [self.latitude_to, self.longitude_to]
  end

  def self.signs_nearest_to(distance)
    order("abs(streetsections.signs.distance - #{distance}")
  end

  def signs_near(distance_from)
    signs = self.signs
    results = []

    signs.each_with_index do |sign, index|
      if sign.distance >= distance_from
        upper_result = sign
        lower_result = signs[index-1]
        results << lower_result
        results << upper_result
        return results
      end
    end
    return results
  end

end


