require 'pry'
require 'csv'
require 'date'

class Block

  attr_accessor :borough_code, :status_order_number, :main_st, :from_st, :to_street, :side_of_street

  def initialize(hash)
    @borough_code = hash[:boroughcode]
    @status_order_number = hash[:statusordernumber]
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
    @status_order_number = hash[:statusordernumber]
    @sign_sequence = hash[:signsequence]
    @distance = hash[:distance]
    @arrow_points = hash[:arrowpoints]
    @sign_discription = hash[:signdiscription]
  end
end

blocks = []
signs = []

CSV.foreach("manhattan_blocks_csv.csv", headers: true, header_converters: :symbol) {|row| blocks << Block.new(row)}

CSV.foreach("manhattan_signs_csv.csv", headers: true, header_converters: :symbol) {|row| signs << Sign.new(row)}