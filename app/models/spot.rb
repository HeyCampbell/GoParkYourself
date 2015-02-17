class Spot < ActiveRecord::Base
  SIGNS_TO_REJECT = ["Building Line", "Curb Line", "Property Line"]

  belongs_to :user

  def initialize(attributes = nil, options = {})
    @encoder_class = options[:encoder_class] || SpotEncoder
    super
    set_address_info
  end

  def user_point
    [self.latitude, self.longitude]
  end

  def nearest_intersection
    GeoNamesAPI.username = ENV['GEONAMES_USERNAME']
    GeoNamesAPI::NearestIntersection.find(self.latitude, self.longitude)
  end

  def set_address_info
    @encoder_class.new(self).encode!
  end

  def get_4_street_segments
    loc = self.nearest_intersection
    main = self.main_street.split(' ')[0].upcase
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
      if GeographicEncoder.get_distance_in_feet(seg.point_to, user_point) <= seg.length && GeographicEncoder.get_distance_in_feet(seg.point_from, user_point) <= seg.length
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


  def set_regs
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
    adjusted_distance = GeographicEncoder.get_distance_in_feet(section.point_from, [latitude, longitude]) - section.buffer
    section.signs_near(adjusted_distance)
  end

  def park_now?
    current_day = Time.now.strftime('%a')
    current_index = Time.now.strftime('%H.%M').to_f * 2
    current_index = current_index.ceil
    regs.map do |reg|
      # byebug
      {reg[:side] => reg[:rules][current_day.to_sym.downcase][:can_i_park][current_index]}
    end
  end

  def park_till
    check_day = Time.now.strftime('%a')
    park_till_day = nil
    park_till_time = nil
    day_offset = 0
    current_index = Time.now.strftime('%H.%M').to_f * 2
    current_index = current_index.ceil
    regs.map do |reg|
      until park_till_day
        if reg[:rules][check_day.to_sym.downcase][:can_i_park][current_index..-1].any? {|sign| sign==false}
          park_till_day = check_day
        end
        day_offset =+ 1
        check_day = Time.now.advance(:day => 1).strftime('%a')
      end
      park_time_index = reg[:rules][check_day.to_sym.downcase][:can_i_park].find_index

      {reg[:side] => [park_till_day, park_till_time]}
      end
    end
  end

  def time_index_to_english(time_index)
    time = time_index.to_f / 2
    hour = time.to_s.split('.')[0].to_i
    minute = time.to_s.split('.')[1].to_i * 6
    if hour == 0
      hour = 12
      am_pm = 'AM'
    elsif hour > 12
      am_pm = 'PM'
      hour = hour / 2
    elsif hour < 12
      am_pm = 'AM'
    elsif hour == 12




  end
end


