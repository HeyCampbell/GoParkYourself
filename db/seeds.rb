require_relative 'convert'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach("manhattan_blocks_csv.csv", headers: true, header_converters: :symbol).each_with_index do |row,index|

  break if index > 30
    StreetSection.create(status_order: row[1], main_street: row[2], from_street: row[3], to_street: row[4], side_of_street: row[5])

end

CSV.foreach("manhattan_signs_csv.csv", headers: true, header_converters: :symbol).each_with_index do |row,index|

  if  StreetSection.exists?(status_order: row[1])
    Sign.create(status_order: row[1], sign_sequence: row[2], distance: row[3], arrow: row[4], sign_description: row[5])
  end
end

