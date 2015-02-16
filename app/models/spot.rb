class Geoencoder
  def initialize(spot)
    @spot
  end

  def encode!
    @spot
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    result = Geocoder.search("#{@spot.latitude}, #{@spot.longitude}").first

    self.main_street = /\d*\s(.*)/.match(result.data["address"]["addressLine"])[1]
    self.full_address = result.data["address"]["formattedAddress"]
  end
end

class BingGeoencoder < Geoencoder
end


class GoogleGeoencoder < Geoencoder
end


class Spot < ActiveRecord::Base
  belongs_to :user
  before_create :encode

  def nearest_intersection
    GeoNamesAPI.username = ENV['GEONAMES_USERNAME']
    GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
  end

  def encode
    Geoencoder.new(self).encode!
  end

  def get_street_sections
    loc = self.nearest_intersection
    StreetSection.two_nearest_street_sections
  end

  def get_signs
    both_side_signs = Hash.new

    self.get_street_sections.each do |section|
      both_side_signs[section.side_of_street] = self.get_signs_for(section)
    end
    both_side_signs
  end

  def get_signs_for(section)
    adjusted_distance = StreetSection.get_distance_in_feet(section.point_from, [latitude, longitude]) - section.buffer
    section.signs_near(adjusted_distance)
  end
end


