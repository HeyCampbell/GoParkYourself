# require 'csv'
# require 'date'
# require 'pry'
# require 'openssl'
# require 'geokit'
# require 'rubygems'
# # include GeoKit::Geocoders

# class Block

#   attr_accessor :borough_code, :status_order_number, :main_st, :from_st, :to_street, :side_of_street

#   def initialize(hash)
#     @borough_code = hash[:boroughcode]
#     @status_order = hash[:statusordernumber]
#     @main_street = hash[:mainstreet]
#     @from_street = hash[:fromstreet]
#     @to_street = hash[:tostreet]
#     @side_of_street = hash[:sideofstreet]
#   end
# end

# class Sign

#   attr_accessor :borough_code, :status_order_number, :sign_sequence, :distance, :arrow_points, :sign_discription

#   def initialize(hash)
#     @borough_code = hash[:boroughcode]
#     @status_order = hash[:statusordernumber]
#     @sign_sequence = hash[:signsequence]
#     @distance = hash[:distance]
#     @arrow = hash[:arrowpoints]
#     @sign_discription = hash[:signdiscription]
#   end
# end