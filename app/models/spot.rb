class Spot < ActiveRecord::Base
  before_create :format_address
  before_create :set_street_name

  def nearest_intersection
    GeoNamesAPI.username = ENV['USERNAME']
    intersection = GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
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
    StreetSection.where("(main_street LIKE '#{self.get_street_name}%' AND latitude_to BETWEEN #{self.nearest_intersection.latitude -.00001} AND #{self.nearest_intersection.latitude+1} AND longitude_to BETWEEN #{self.nearest_intersection.longitude -1} AND #{self.nearest_intersection.longitude+1}) OR (main_street LIKE '#{get_street_name}%' AND latitude_from BETWEEN #{self.nearest_intersection.latitude -1} AND #{self.nearest_intersection.latitude+1} AND longitude_from BETWEEN #{self.nearest_intersection.longitude -1} AND #{self.nearest_intersection.longitude+1})")
  end
end
