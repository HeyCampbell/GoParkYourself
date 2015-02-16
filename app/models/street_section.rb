class StreetSection < ActiveRecord::Base
  has_many :signs, :foreign_key => 'status_order', :primary_key => 'status_order'
  before_save :get_point_from, :get_point_to

  def borough_name
    case borough
    when "M"
      return "Manhattan"
    when "B"
      return "Bronx"
    when "K"
      return "Brooklyn"
    when "Q"
      return "Queens"
    end
  end

  def get_point_from
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    result = Geocoder.search("#{main_street} and #{from_street}, Manhattan, New York")[0]
    if result
      self.latitude_from = result.data["point"]["coordinates"][0]
      self.longitude_from = result.data["point"]["coordinates"][1]
    end
    sleep(0.2)
  end

  def get_point_to
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    result = Geocoder.search("#{main_street} and #{to_street}, Manhattan, New York")[0]
    if result
      self.latitude_to = result.data["point"]["coordinates"][0]
      self.longitude_to = result.data["point"]["coordinates"][1]
    end
    sleep(0.2)
  end

  def self.get_distance_in_feet(point1, point2) #( [lat2, lng2], [lat1, lng1] )
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    (Geocoder::Calculations.distance_between(point1, point2)*5280).to_i
  end

  def point_from
    [latitude_from, longitude_from]
  end

  def point_to
    [latitude_to, longitude_to]
  end

  def length
    StreetSection.get_distance_in_feet(point_from, point_to)
  end

  def buffer
    (self.length - self.signs.last.distance) / 2
  end

  def signs_near(distance_from)
    signs = self.signs
    results = []


      signs.each_with_index do |sign, index|

        if sign.distance >= distance_from
          upper_result = sign
          lower_result = signs[index-1]

          results << signs.find_all{|s| s.distance == lower_result.distance}
          results << signs.find_all{|s| s.distance == upper_result.distance}

          return results.flatten!
        end
      end

      return results
  end

  def self.rephresh_gps
    StreetSection.all.each do |sect|
      sect.get_point_from
      sect.save
      sect.get_point_to
      sect.save
    end
  end
end



