class StreetSectionEncoder < GeographicEncoder
  def initialize(encodable)
    super(encodable)
  end

  def encode!
    to_result = self.cross_streets_lookup(@encodable.main_street, @encodable.to_street)
    if to_result
      @encodable.latitude_to = to_result.data["point"]["coordinates"][0]
      @encodable.longitude_to = to_result.data["point"]["coordinates"][1]
    end
    sleep(0.3)

    from_result = self.cross_streets_lookup(@encodable.main_street, @encodable.from_street)
    if from_result
      @encodable.latitude_from = from_result.data["point"]["coordinates"][0]
      @encodable.longitude_from = from_result.data["point"]["coordinates"][1]
    end
    sleep(0.2)
  end

  def cross_streets_lookup(mainstreet, sidestreet)
    if mainstreet && sidestreet
      @geocoder.search("#{mainstreet} and #{sidestreet}, Manhattan, New York")[0]
    else
      nil
    end
  end

end