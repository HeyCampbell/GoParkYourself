class GeographicEncoder

  def initialize(encodable)
    @encodable = encodable
  end

  def encode!
    raise "Must be implemented"
  end

  def reverse_lookup(latitude, longitude)
    Geocoder.search("#{latitude}, #{longitude}")[0]
  end

  def cross_streets_lookup(mainstreet, sidestreet)
    Geocoder.search("#{mainstreet} and #{sidestreet}, Manhattan, New York")[0]
  end

  def self.get_distance_in_feet(point1, point2)
    (Geocoder::Calculations.distance_between(point1, point2)*5280).to_i
  end

end

class SpotEncoder < GeographicEncoder
  def initialize(encodable)
    super(encodable)
  end

  def encode!
    result = reverse_lookup(@encodable.latitude, @encodable.longitude)
    @encodable.main_street = /\d*\s(.*)/.match(result.data["address"]["addressLine"])[1]
    @encodable.full_address = result.data["address"]["formattedAddress"]
  end
end

class StreetSectionEncoder < GeographicEncoder
  def initialize(encodable)
    super(encodable)
  end

  def encode!
    to_result = self.cross_streets_lookup(@encodable.main_street, @encodable.to_street)
    if to_result.data
      @encodable.latitude_to = to_result.data["point"]["coordinates"][0]
      @encodable.longitude_to = to_result.data["point"]["coordinates"][1]
    end
    sleep(0.3)

    from_result = self.cross_streets_lookup(@encodable.main_street, @encodable.from_street)
    if from_result.data
      @encodable.latitude_from = from_result.data["point"]["coordinates"][0]
      @encodable.longitude_from = from_result.data["point"]["coordinates"][1]
    end
    sleep(0.2)
  end

end
