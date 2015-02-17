class GeographicEncoder

  def initialize(encodable, opts = {})
    @encodable = encodable
    @geocoder = opts[:geocoder] || Geocoder
  end

  def encode!
    raise "Must be defined to add attributes to the encodable"
  end
end