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




