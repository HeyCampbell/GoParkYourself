class Spot < ActiveRecord::Base
  SIGNS_TO_REJECT = ["Building Line", "Curb Line", "Property Line"]

  belongs_to :user
  before_create :set_address_info

  def user_point
    [self.latitude, self.longitude]
  end

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

  # def get_street_sections #should return 2
  #   loc = self.nearest_intersection

  #   StreetSection.where("(main_street LIKE '#{self.main_street.upcase}%' AND latitude_to BETWEEN #{loc.intersection['lat'].to_f - 0.00005} AND #{loc.intersection['lat'].to_f + 0.00005} AND longitude_to BETWEEN #{loc.intersection['lng'].to_f - 0.00005} AND #{loc.intersection['lng'].to_f + 0.00005}) OR (main_street LIKE '#{main_street.upcase}%' AND latitude_from BETWEEN #{loc.intersection['lat'].to_f - 0.00005} AND #{loc.intersection['lat'].to_f + 0.00005} AND longitude_from BETWEEN #{loc.intersection['lng'].to_f - 0.00005} AND #{loc.intersection['lng'].to_f + 0.00005})")
  # end

  def get_4_street_segments
    loc = self.nearest_intersection
    main = self.main_street.split(' ')[0].upcase
    # byebug
    if loc.intersection['street1'].split(' ')[0].upcase == self.main_street.split(' ')[0].upcase
      alt_street = loc.intersection['street2'].split(' ')[0].upcase
    else
      alt_street = loc.intersection['street1'].split(' ')[0].upcase
    end

    main_block = StreetSection.where("main_street LIKE '#{main}%'")
    main_block.where("to_street LIKE '#{alt_street}%' OR from_street LIKE '#{alt_street}%'")
  end

  def find_section
    users_block = []
    segments = get_4_street_segments
    segments.each do |seg|
      if StreetSection.get_distance_in_feet(seg.point_to, user_point) <= seg.length && StreetSection.get_distance_in_feet(seg.point_from, user_point) <= seg.length
        users_block << seg
      end
    end
    users_block
  end

  def get_signs
    both_side_signs = Hash.new
    self.find_section.each do |section|
      both_side_signs[section.side_of_street] = self.get_signs_for(section)
    end
    both_side_signs
  end

  def sign_picker
    signs = get_signs
    signs.each do |direction, side|
      side.reject! do |sign|
        /#{SIGNS_TO_REJECT.join('|')}/.match(sign.sign_description)
      end
    end

    signs
  end


  def regs
    self.sign_picker.map do |k,v|
      if v[0]
        rules = v[0].no_parking_times
      elsif v.empty?
        rules = "error parsing rules"
      else
        rules = v
      end
      {side: k , rules: rules}
    end
  end

  def get_signs_for(section)
    adjusted_distance = StreetSection.get_distance_in_feet(section.point_from, [latitude, longitude]) - section.buffer
    section.signs_near(adjusted_distance)
  end
end


