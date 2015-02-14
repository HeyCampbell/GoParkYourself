class Spot < ActiveRecord::Base
  before_create :format_address
  before_create :set_street_name

  def nearest_intersection
    GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
  end

  def get_street_name
    result = Geocoder.search("#{latitude}, #{longitude}")[0]
    result.data["address_components"][1]["long_name"]
  end

  def set_street_name
    self.main_street = self.get_street_name
  end

  def format_address
    self.full_address = Geocoder.search("#{latitude}, #{longitude}")[0].data["formatted_address"]
  end

  def get_street_sections #should return 2
    loc = self.nearest_intersection
    StreetSection.where("(main_street LIKE '#{self.get_street_name.upcase}' AND latitude_to BETWEEN #{loc.intersection['lat'].to_f - 0.0001} AND #{loc.intersection['lat'].to_f + 0.0001} AND longitude_to BETWEEN #{loc.intersection['lng'].to_f - 0.0001} AND #{loc.intersection['lng'].to_f + 0.0001}) OR (main_street LIKE '#{get_street_name.upcase}%' AND latitude_from BETWEEN #{loc.intersection['lat'].to_f - 0.0001} AND #{loc.intersection['lat'].to_f + 0.0001} AND longitude_from BETWEEN #{loc.intersection['lon'].to_f - 0.0001} AND #{loc.intersection['lon'].to_f + 0.0001})")

  end


end



