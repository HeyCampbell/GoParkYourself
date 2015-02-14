class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'


  def no_parking_times
    parktag = "Never Park here "
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
          time_range = /((\d|\d:\d*)-(\d|\d:\d*)[APM]{2})/.match(self.sign_description)
          parking_regs.each do |k,v|

            unless k.to_s == unaffected_day[0..2].downcase
              parking_regs[k] = "#{time_range}"
            end
          end
        parktag = 'Street cleaner comes here'
        end
      end
    elsif /NO STANDING/.match(self.sign_description)
      parktag ="No Standing Sign"
    elsif /1 HOUR PARKING/.match(self.sign_description)
      parktag ="1 hour parking sign"
    elsif /Curb Line/.match(self.sign_description) || /Building Line/.match(self.sign_description) || /Property Line/.match(self.sign_description)
      parktag =''
    else
      parktag ="I'm sorry Dave, I can't read that just yet. I'll try harder"
    end
    parsed_regs = parking_regs.map{|k,v| "#{k}=#{v}"}.join(' & ')
    "#{parsed_regs}"
  end
end
