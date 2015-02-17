class StreetSection < ActiveRecord::Base

  SYMBOLS_TO_BOROUGHS = {"M" => "Manhattan", "B" => "Bronx", "K" => "Brooklyn", "Q" => "Queens"}

  has_many :signs, :foreign_key => 'status_order', :primary_key => 'status_order'
  before_create :set_encoder_class, :set_encoder, :encode_cross_streets

  def borough_name
    SYMBOLS_TO_BOROUGHS(borough)
  end

  def set_encoder_class(args = {})
    @encoder_class = args[:encoder_class] || StreetSectionEncoder
  end

  def set_encoder
    @encoder = @encoder_class.new(self)
  end

  def encode_cross_streets
    @encoder.encode!
  end

  def point_from
    [latitude_from, longitude_from]
  end

  def point_to
    [latitude_to, longitude_to]
  end

  def length
    GeographicEncoder.get_distance_in_feet(point_from, point_to)
  end

  def buffer
    (self.length - self.signs.last.distance) / 2
  end

  def signs_near(distance_from)
    signs = self.signs
    results = []
      signs.each_with_index do |sign, index|
        if sign.distance >= distance_from
          upper_result = sign
          lower_result = signs[index-1]
          results << signs.find_all{|s| s.distance == lower_result.distance}
          results << signs.find_all{|s| s.distance == upper_result.distance}
          return results.flatten!
        end
      end
      return results
  end

  def self.refresh_gps
    StreetSection.all.each do |sect|
      sect.get_point_from
      sect.save
      sect.get_point_to
      sect.save
    end
  end
end



