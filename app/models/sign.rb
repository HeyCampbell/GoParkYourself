class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'


  def no_parking_times
    # parktag = "Never Park here "
    parking_regs = {mon: 'No Regulation',
        tue: 'No Regulation',
        wed: 'No Regulation',
        thu: 'No Regulation',
        fri: 'No Regulation',
        sat: 'No Regulation',
        sun: 'No Regulation'}
    if /NO PARKING/.match(self.sign_description)
      if /SANITATION BROOM SYMBOL/.match(self.sign_description)
        if /EXCEPT/.match(self.sign_description)
          unaffected_day = /\bEXCEPT\s+\K\S+/.match(self.sign_description).to_s
          time_range = /((\d|\d:\d*)[APM]*-(\d|\d:\d*)[APM]{2})/.match(self.sign_description).to_s
          am_pm = /[APM]/.match(time_range.to_s)
          times = time_range.split('-')
          unless /[APM]/.match(times[0])
            times[0] += am_pm
          end
          parking_regs.each do |k,v|
            unless k.to_s == unaffected_day[0..2].downcase
              parking_regs[k] = {:start => times[0], :stop => times[1]}
            else
              parking_regs[k] = 0
            end
          end

        # parktag = 'Street cleaner comes here'
        end
      elsif /ANYTIME/.match(self.sign_description)
        parking_regs = parking_regs.map {|k,v| {k => {:start => "12:00am", :stop => "12:00am"}}}
      end
    elsif /NO STANDING/.match(self.sign_description)
      parking_regs = parking_regs.map {|k,v| {k => {:start => "12:00am", :stop => "12:00am"}}}
    elsif /1 HOUR PARKING/.match(self.sign_description)
      parking_regs =parking_regs.map {|k,v| {k => "1 hour parking"}}
    elsif /Curb Line/.match(self.sign_description) || /Building Line/.match(self.sign_description) || /Property Line/.match(self.sign_description)
      parking_regs =parking_regs.map {|k,v| {k => 0}}
    else
      parktag ="I'm sorry Dave, I can't read that just yet. I'll try harder"
    end
    # parsed_regs = parking_regs.map{|k,v| "#{k}=#{v}"}.join(' & ')
    parking_regs
  end
end
