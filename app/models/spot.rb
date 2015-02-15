class Spot < ActiveRecord::Base
  belongs_to :user
  before_create :set_address_info

  def nearest_intersection
    GeoNamesAPI.username = ENV['GEONAMES_USERNAME']
    GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
  end

  def set_address_info
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    result = Geocoder.search("#{latitude}, #{longitude}")[0]

    self.main_street = /\d*\s(.*)/.match(result.data["address"]["addressLine"])[1]
    self.full_address = result.data["address"]["formattedAddress"]
  end

  def get_street_sections #should return 2
    loc = self.nearest_intersection
    StreetSection.where("(main_street LIKE '#{self.main_street.upcase}%' AND latitude_to BETWEEN #{loc.intersection['lat'].to_f - 0.00005} AND #{loc.intersection['lat'].to_f + 0.00005} AND longitude_to BETWEEN #{loc.intersection['lng'].to_f - 0.00005} AND #{loc.intersection['lng'].to_f + 0.00005}) OR (main_street LIKE '#{main_street.upcase}%' AND latitude_from BETWEEN #{loc.intersection['lat'].to_f - 0.00005} AND #{loc.intersection['lat'].to_f + 0.00005} AND longitude_from BETWEEN #{loc.intersection['lng'].to_f - 0.00005} AND #{loc.intersection['lng'].to_f + 0.00005})")

  end

  def get_signs
    both_side_signs = Hash.new

    self.get_street_sections.each do |section|
      both_side_signs[section.side_of_street] = self.get_signs_for(section)
    end
    both_side_signs
  end

  def get_signs_for(section)
    adjusted_distance = StreetSection.get_distance_in_feet(section.point_from, [latitude, longitude]) + section.buffer
    section.signs_near(adjusted_distance)
  end
end


