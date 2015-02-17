require 'rails_helper'
require 'factory_girl_rails'

describe "GeographicEncoder" do
  let(:point) {[40.708710, -74.010646]}
  # let(:encoder) {FactoryGirl.create(:geographic_encoder)}

#instances methods

  describe "#initialize" do
    it "should have an encodable object" do
      expect(geographic_encoder.encodable.count).to eq(1)
    end

    xit "should be configured with bing API key" do
      expect(Geocoder.)
    end
  end

  describe "#reverse_lookup(lat, long)" do
    xit "should return an object when given a point of latitude and longitude" do
      expect(reverse_lookup(point)).to eq()
    end

    xit "should return an error when presented with coordinates that are not a latitude and longitude" do
      expect().to eq()
    end

  end

  describe "#encode!" do

    it "should" do
    end

    it "" do
    end

  end

  describe "#cross_streets_lookup(mainstreet, sidestreet)" do

    it "should" do
    end

    it "" do
    end

  end

#class methods

  describe "self.get_distance_in_feet(point1, point2)" do

    it "should " do

    end

    it "" do

    end

  end

end