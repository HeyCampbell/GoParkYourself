class GeographicEncoder

  def initialize(encodable, opts = {})
    @encodable = encodable
    @geocoder = opts[:geocoder] || Geocoder
  end

  def encode!
    raise "Must be defined to add attributes to the encodable"
  end

  def cross_streets_lookup(mainstreet, sidestreet)
    @geocoder.search("#{mainstreet} and #{sidestreet}, Manhattan, New York")[0]
  end

  def self.get_distance_in_feet(point1, point2)
    (@geocoder::Calculations.distance_between(point1, point2)*5280).to_i
  end

end