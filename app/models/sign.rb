class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'

  def no_parking_times
    if /NO PARKING/.match(self.sign_description)
      if /SANITATION BROOM SYMBOL/.match(self.sign_description)
        return 'Street cleaner comes here'
      else
        return "Never Park here sign"
      end
    elsif /NO STANDING/.match(self.sign_description)
      return "No Standing Sign"
    elsif /1 HOUR PARKING/.match(self.sign_description)
      return "1 hour parking sign"
    elsif /CURB LINE/.match(self.sign_description) || /BILDING LINE/.match(self.sign_description)
      return ''
    else
      return "I'm sorry Dave, I can't read that just yet. I'll try harder"
    end

  end
end
