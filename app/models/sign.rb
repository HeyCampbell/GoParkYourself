class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'
  attr_reader  :times
  def initialize
    @times = []

  end

  def self.no_parking_times(desc)
    parking_regs = {mon: desc,
        tue: desc,
        wed: desc,
        thu: desc,
        fri: desc,
        sat: desc,
        sun: desc}
    unaffected_day = []

    if /NO PARKING/.match(desc) || /HOUR PARKING/.match(desc) ||/NO STANDING/.match(desc) || /NO STOPPING/.match(desc)
      if /ANYTIME/.match(desc)
        @times = ["12AM", "12AM"]
      else
        if /((\d*|\d:\d*)[APM]*)/.match(desc)
          @times = Sign.parse_times_from_description(desc)
          times_48 = Sign.get_48_times(@times)
        end
        if /EXCEPT/.match(desc)
          unaffected_day << /\bEXCEPT\s+\K\S+/.match(desc).to_s[0..2]
        elsif /THRU/.match(desc)
          week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
          range = []
          week.each_with_index do |day, index|
            if /#{day}/.match(desc)
              range << index
            end
          end
          week.each_with_index do |day, index|
            if index < range[0] or index > range[1]
              unaffected_day << day
            end
          end
        end
      end
      parking_regs.each do |k,v|
        unless unaffected_day.include?(k.to_s.upcase)

          parking_regs[k] = {:start => @times[0], :stop => @times[1], :can_i_park => set_48_times(@times)}
        else
          parking_regs[k] = {:start => "0", :stop => "0", :can_i_park => set_48_times(@times)}
        end
      end
    elsif /Curb Line/.match(desc) || /Building Line/.match(desc) || /Property Line/.match(desc)
      parking_regs.each do |k,v|
        parking_regs[k] = {:start => "0", :stop => "0", :can_i_park => set_48_times(@times)}
      end
    else
      parking_regs = parking_regs.map {|k,v| {k => desc}}
    end
    parking_regs
  end

  def self.parse_times_from_description(desc)
    time_range = /((\d*|\d:\d*)[APM]*-(\d*|\d:\d*)[APM]+)/.match(desc).to_s || /((\d*|\d:\d*)[APM]*)/.match(desc).to_s
    am_pm = /[APM]/.match(time_range.to_s)
    times = time_range.split('-')
    unless /[APM]/.match(times[0])
      times[0] += am_pm.to_s
    end
    times
  end

  def self.get_48_times(times)
    times = times.map do |t|
      if /12:*\d*P*/.match(t) || /AM*/.match(t)
        buffer = 0
      elsif /12:*\d*[PM]/.match(t)
        buffer = -12
      elsif /PM/.match(t)
        buffer = 12
      end
      base = t.gsub(':','.').to_f
      base += buffer
      base *= 2
    end
    times[1] -= 1
    times
  end

  def self.set_48_times(times)
    if times == ["12AM", "12AM"]
      return Array.new(48, false)
    end
    time_index = Sign.get_48_times(times)
    parking_times = Array.new(48, true)
    parking_times.each_with_index.map do |increment, i|
      if i >= time_index[0] && i <= time_index[1]
        increment = false
      else
        increment = true
      end
    end
  end
end


