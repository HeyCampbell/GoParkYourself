require 'rails_helper'
require 'factory_girl_rails'

describe "Street Section" do

  # let(:street) { StreetSection.find_by(status_order: 'P-255161') }
  let(:street) { StreetSection.create(:street_section) }
  let(:new_street) { FactoryGirl.build(:street_section) }
  let(:created_spot) { Spot.create(latitude: 40.705765, longitude: -74.007659, remind?: true )}
  let(:sections) {created_spot.get_street_sections}
  let(:intersection) {created_spot.nearest_intersection}

  it "is valid with a mainstreet, to_street, from_street, and status order" do
    expect(FactoryGirl.create(:street_section)).to be_valid
  end

  it 'should be associated with a status order' do
    expect(street.status_order.class).to eq(String)
  end

  it "should have a main street" do
    expect(street.main_street).to eq('PEARL STREET')
  end

  describe "#get_point_to" do
    before :each do
      @new_street = FactoryGirl.build(:street_section)
    end

    it "should set the latitude of to_street intersection" do
      @new_street.save
      expect(@new_street.latitude_to.to_f).to eq(40.7060419)
    end

    xit "should set the longitude of to_street intersection" do
      @new_street.save
      expect(@new_street.longitude_to.to_f).to eq()
    end
  end

  describe "#get_point_from" do
    xit "should set the latitude of from_street intersection" do
      @new_street.save
      expect(@new_street.latitude_from.to_f).to eq(40.7060419)
    end

    xit "should set the longitude of from_street intersection" do
      @new_street.save
      expect(@new_street.longitude_from.to_f).to eq(40.7060419)
    end
  end

  describe "self.get_distance_in_feet(p1, p2)" do
    xit "should calculate the positive distance between two points in feet" do
      dist = StreetSection.get_distance_in_feet(street.point_from, point_to)
      expect(dist > 0).to eq(true)
    end
  end

  describe "#point_from" do
    it "should return an array of two points" do
      expect(street.point_from.length).to eq(2)
    end
  end

  describe "#point_to" do
    it "should return an array of two points" do
      expect(street.point_to.length).to eq(2)
    end

    it "should return the point's latitude as first element in array" do
      expect(street.point_to[0]).to eq(street.latitude_to.to_f)
    end
  end

  describe "#length" do
    it "should return a postive integer" do
      expect(street.length).to be_instance_of(Fixnum)
    end

    it "should return a number greater than the distance of last sign of street section from the starting curb" do
      expect(street.length > street.signs.last.distance).to eq(true)
    end
  end

  describe "#buffer" do
    it "should return a positive number (of feet)" do
      expect(street.buffer > 1).to be(true)
    end

    it "should be less than the length of the street" do
      expect(street.buffer < street.length).to be(true)
    end
  end
end

