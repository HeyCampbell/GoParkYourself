class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'

  def no_parking_times
    parking_regs = {mon: self.sign_description,
        tue: self.sign_description,
        wed: self.sign_description,
        thu: self.sign_description,
        fri: self.sign_description,
        sat: self.sign_description,
        sun: self.sign_description}
    unaffected_day = []
    if /NO PARKING/.match(self.sign_description) || /NO STANDING/.match(self.sign_description)
      if /ANYTIME/.match(self.sign_description)
        times = ["12:00am", "11:59pm"]
      else
        times = self.parse_times_from_description(self.sign_description)
        if /EXCEPT/.match(self.sign_description)
          unaffected_day << /\bEXCEPT\s+\K\S+/.match(self.sign_description).to_s[0..2]
        elsif /THRU/.match(self.sign_description)
          week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
          range = []
          week.each_with_index do |day, index|
            if /#{day}/.match(self.sign_description)
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
          parking_regs[k] = {:start => times[0], :stop => times[1]}
        else
          parking_regs[k] = {:start => 0, :stop => 0}
        end
      end
    elsif /Curb Line/.match(self.sign_description) || /Building Line/.match(self.sign_description) || /Property Line/.match(self.sign_description)
      parking_regs =parking_regs.map {|k,v| {k => {:start => 0, :stop => 0}}}
    else
      parking_regs =parking_regs.map {|k,v| {k => "I'm sorry Dave, I can't read that just yet. I'll try harder"}}
    end
    # parsed_regs = parking_regs.map{|k,v| "#{k}=#{v}"}.join(' & ')
    parking_regs
  end

  def parse_times_from_description(desc)

    time_range = /((\d*|\d:\d*)[APM]*-(\d*|\d:\d*)[APM]+)/.match(desc).to_s || /((\d*|\d:\d*)[APM]*)/.match(desc).to_s
    am_pm = /[APM]/.match(time_range.to_s)
    times = time_range.split('-')
    unless /[APM]/.match(times[0])
      times[0] += am_pm.to_s
    end
    times
  end

end


