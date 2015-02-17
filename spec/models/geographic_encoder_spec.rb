require 'rails_helper'
require 'factory_girl_rails'

describe "GeographicEncoder" do
  let(:encoder) {FactoryGirl.create(:geographic_encoder)}

  describe "#initialize" do
    it "should have an encodable object" do
      expect(geographic_encoder.encodable.count).to eq(1)
    end

    it "should be configured with bing API key" do
      expect(Geocoder.)
    end
  end

  describe "#reverse_lookup(lat, long)" do
    it "should return an object when given a point of latitude and longitude" do
      expect().to eq()
    end

    it "should return an error when presented with coordinates that are not a latitude and longitude" do
      expect().to eq()
    end

  end

  it "should" do
  end

  it "" do
  end

  it "" do
  end

  it "" do
  end

end