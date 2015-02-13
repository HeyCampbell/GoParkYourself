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

end
