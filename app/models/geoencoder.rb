class Geoencoder

  def initialize
    @api_key = ENV['BING_KEY']
    @lookup = :bing
  end

  def configure
    Geocoder.configure(api_key: @api_key, lookup: @lookup)
  end

  def encode(spot)
    result = reverse_lookup(spot.latitude, spot.longitude)
    spot.main_street = /\d*\s(.*)/.match(result.data["address"]["addressLine"])[1]
    spot.full_address = result.data["address"]["formattedAddress"]
  end

  def reverse_lookup(latitude, longitude)
    self.configure
    Geocoder.search("#{latitude}, #{longitude}")[0]
  end

end
