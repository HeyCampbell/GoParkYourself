require 'rails_helper'
require 'factory_girl_rails'
require 'byebug'

describe "GeographicEncoder" do
  let(:point) {[40.708710, -74.010646]}
  let(:spot) {FactoryGirl.create(:spot)}
  # let(:test_encoder) {GeographicEncoder.new(spot)}
  let(:test_encoder) {GeographicEncoder.new("encodable")}

#instances methods

  describe "#initialize" do
    it "should have an encodable object" do
      expect(test_encoder.encodable.count).to eq(1)
    end

    it "should have geocoder configured to use Bing maps API" do
      expect(Geocoder.config[:lookup]).to eq(:bing)
    end

    it "should have a BING API key available as variable in the environment" do
      expect(ENV['BING_KEY']).to_not be(nil)
    end

    it "should be configured with bing API key" do
      expect(Geocoder.config[:api_key].class).to eq(String)
    end
  end

  describe "#reverse_lookup(lat, long)" do
    it "should return an object when given a point of latitude and longitude" do
      byebug
      expect(reverse_lookup(point)).to eq()
    end

    it "should return an error when presented with coordinates that are not a latitude and longitude" do
      expect().to eq()
    end

  end

  describe "#encode!" do

    xit "should" do
    end

    xit "" do
    end
  end

  describe "#cross_streets_lookup(mainstreet, sidestreet)" do

    xit "should" do
    end

    xit "" do
    end

  end

#class methods

  describe "#self.get_distance_in_feet(point1, point2)" do

    xit "should " do
    end

    xit "should" do
    end
  end

end