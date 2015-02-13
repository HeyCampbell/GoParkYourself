require 'csv'
require 'date'
require 'pry'

class Block

  attr_accessor :borough_code, :status_order_number, :main_st, :from_st, :to_street, :side_of_street

  def initialize(hash)
    @borough_code = hash[:boroughcode]
    @status_order = hash[:statusordernumber]
    @main_street = hash[:mainstreet]
    @from_street = hash[:fromstreet]
    @to_street = hash[:tostreet]
    @side_of_street = hash[:sideofstreet]
  end
end

class Sign

  attr_accessor :borough_code, :status_order_number, :sign_sequence, :distance, :arrow_points, :sign_discription

  def initialize(hash)
    @borough_code = hash[:boroughcode]
    @status_order = hash[:statusordernumber]
    @sign_sequence = hash[:signsequence]
    @distance = hash[:distance]
    @arrow = hash[:arrowpoints]
    @sign_discription = hash[:signdiscription]
  end
end

# CSV.foreach("manhattan_blocks_csv.csv", headers: true, header_converters: :symbol).each_with_index do |row,index|

#   if index > 30
#     StreetSection.create(status_order: row[1], main_street: row[2], from_street: row[3], to_street: row[4], side_of_street: row[5])
#   end

# end

# CSV.foreach("manhattan_signs_csv.csv", headers: true, header_converters: :symbol).each_with_index do |row,index|

#   binding.pry
#   signs << Sign.new(row)

# end