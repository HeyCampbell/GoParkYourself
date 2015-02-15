class Spot < ActiveRecord::Base
  before_create :format_address
  before_create :set_street_name

  def nearest_intersection

    GeoNamesAPI.username = ENV['GEONAMES_USERNAME']
    GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
  end

  def get_street_name
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    result = Geocoder.search("#{latitude}, #{longitude}")[0]
    /\d*\s(.*)/.match(result.data["address"]["addressLine"])[1]
  end

  def set_street_name
    self.main_street = self.get_street_name
  end

  def format_address
    Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
    self.full_address = Geocoder.search("#{latitude}, #{longitude}")[0].data["address"]["formattedAddress"]
  end

  def get_street_sections #should return 2
    loc = self.nearest_intersection
    StreetSection.where("(main_street LIKE '#{self.get_street_name.upcase}' AND latitude_to BETWEEN #{loc.intersection['lat'].to_f - 0.0001} AND #{loc.intersection['lat'].to_f + 0.0001} AND longitude_to BETWEEN #{loc.intersection['lng'].to_f - 0.0001} AND #{loc.intersection['lng'].to_f + 0.0001}) OR (main_street LIKE '#{get_street_name.upcase}%' AND latitude_from BETWEEN #{loc.intersection['lat'].to_f - 0.0001} AND #{loc.intersection['lat'].to_f + 0.0001} AND longitude_from BETWEEN #{loc.intersection['lng'].to_f - 0.0001} AND #{loc.intersection['lng'].to_f + 0.0001})")

  end

  def get_signs
    all_signs = Hash.new
    sections = get_street_sections

    sections.each do |section|
      all_signs[section.side_of_street] = self.get_signs_for(section)
    end

  end

  def get_signs_for(section)

    section_length = StreetSection.get_distance_in_feet(section.point_from, section.point_to)

     buffer = (section_length - section.signs.last.distance) / 2

     car_distance = StreetSection.get_distance_in_feet(section.point_from, [latitude, longitude]) + buffer

     section.signs_near(car_distance)

  end

end



