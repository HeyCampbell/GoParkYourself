class Sign < ActiveRecord::Base
  belongs_to :street_section, :foreign_key => 'status_order', :primary_key => 'status_order'
end