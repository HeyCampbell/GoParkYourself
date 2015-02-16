require 'rails_helper'
require 'factory_girl_rails'

describe "Street Section" do

  let(:street) { FactoryGirl.create(:street_section) }
  let(:created_spot) { Spot.create(latitude: 40.705765, longitude: -74.007659, remind?: true )}
   let(:sections) {created_spot.get_street_sections}
   let(:intersection) {created_spot.nearest_intersection}

  it "is valid with a mainstreet, to_street, and from_street" do
    expect(FactoryGirl.create(:street_section)).to be_valid
  end

  it 'should be associated with a status order' do
    expect(street.status_order.class).to eq(String)
  end

  it "should have a main street" do
    expect(street.main_street).to eq('PEARL STREET')
  end

  describe "#get_point_to" do
    it "" do
      expect(street.to_latitude).to eq(40.7060419)
    end
  end

  describe "#get_point_from" do
    it "" do
      expect(street.from_lat).to eq(40.7060419)
    end
  end

  describe "self.get_distance_in_feet(p1, p2)" do
    it "" do
      expect(street.from_lat).to eq(40.7060419)
    end
  end

  describe "#point_from" do
    it "should return a " do
      [latitude_from, longitude_from]
    end
  end

  describe "#point_to" do
    it "should return a " do
      [latitude_to, longitude_to]
    end
  end

  describe "#length" do

  end

  def length
    StreetSection.get_distance_in_feet(point_from, point_to)
  end

  def buffer
    (self.length - self.signs.last.distance) / 2
  end

  it "" do
    expect(street.from_lat).to eq(40.7060419)
  end

  xit "should calculate length of street section rounded to nearest feet" do
    expect(street.length).to eq(229)
  end
end

