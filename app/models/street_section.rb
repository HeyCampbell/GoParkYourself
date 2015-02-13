class StreetSection < ActiveRecord::Base
    has_many :signs, :foreign_key => 'status_order', :primary_key => 'status_order'

end