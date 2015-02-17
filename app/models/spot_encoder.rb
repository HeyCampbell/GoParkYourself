class SpotEncoder < GeographicEncoder
  def initialize(encodable)
    super(encodable)
  end

  def encode!
    result = reverse_lookup(@encodable.latitude, @encodable.longitude)
    @encodable.main_street = /\d*(\d*[a-z]*.*)/.match(result.data["address"]["addressLine"])[1]
    @encodable.full_address = result.data["address"]["formattedAddress"]
  end

  private

    def reverse_lookup(latitude, longitude)
     @geocoder.search("#{latitude}, #{longitude}")[0]
    end
end