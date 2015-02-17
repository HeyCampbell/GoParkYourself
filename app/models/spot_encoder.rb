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