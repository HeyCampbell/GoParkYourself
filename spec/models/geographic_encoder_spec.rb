require 'rails_helper'

describe "GeographicEncoder" do
  let(:point) {[40.708710, -74.010646]}
  let(:spot) {FactoryGirl.create(:spot)}
  # let(:test_encoder) {GeographicEncoder.new(spot)}
  let(:test_encoder) {GeographicEncoder.new("encodable")}

#instance methods

  describe "#initialize" do
    it "should have an encodable object" do
      expect(test_encoder.encodable).to eq("encodable")
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

  describe "#encode!" do
    xit "should raise an error if attempt to implement" do
      expect{GeographicEncoder.new("encodable").encode!}.to raise_error()
    end
  end

#class methods

  describe "#self.get_distance_in_feet(point1, point2)" do
    xit "should return a positive integer" do

    end
  end

end