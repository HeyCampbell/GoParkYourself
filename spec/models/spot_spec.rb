require 'rails_helper'
require 'factory_girl_rails'
require 'byebug'

describe "Spot" do
   let(:created_spot) { Spot.create(latitude: 40.705765, longitude: -74.007659, remind?: true )}
   let(:pearl_cedar_spot) {Spot.create(latitude: 40.706270, longitude: -74.007170)}
   # let(:sections) {pearl_cedar_spot.get_street_sections}
   let(:intersection) {pearl_cedar_spot.nearest_intersection}

  before :each do
    @spot = Spot.new(latitude: 40.705765, longitude: -74.007659, remind?: true )
  end

  it "should initialize with latitude coordinate" do
    expect(@spot.latitude.to_f).to eq(40.705765)
  end

  it "should initialize with longitude coordinate" do
    expect(@spot.longitude.to_f).to eq(-74.007659)
  end

  describe "#set_address_info" do
    it "should save with an address string pulled from Geocoder bing maps api" do
      @spot.save
      expect(@spot.full_address.class).to eq(String)
    end

    it "should save with an accurate address pulled from Geocoder" do
      # address = Geocoder.configure(api_key: ENV['BING_KEY'], lookup: :bing)
      @spot.save
      expect(@spot.full_address).to eq("162 Pearl St, New York, NY 10005")
    end

    it "should save with a main_street string" do
      @spot.save
      expect(@spot.main_street.class).to eq(String)
    end
  end

  describe "nearest_intersection" do
    it "should have access to geonames username environment variable" do
      expect(ENV['GEONAMES_USERNAME'].class).to eq(String)
    end

    it "should return a geonames intersection object" do
      expect(intersection.class).to eq(GeoNamesAPI::NearestIntersection)
    end

    it "should return an intersection in New York county (manhattan)" do
      expect(intersection.intersection["adminName2"]).to eq("New York")
    end

  end

  describe "#get_street_sections" do

    it "should return two street sections" do
      sections = pearl_cedar_spot.get_street_sections
      expect(sections.count).to eq(2)
    end

    it "should return street section with same mainstreet as spot" do
      sections = pearl_cedar_spot.get_street_sections
      expect(pearl_cedar_spot.main_street.upcase).to eq(sections[0].main_street.upcase)
    end

    it "should return street section with same mainstreet as spot" do
      sections = pearl_cedar_spot.get_street_sections
      expect(pearl_cedar_spot.main_street.upcase).to eq(sections[1].main_street.upcase)
    end
  end

  describe "#get_signs_for(section)" do
    xit "should return relevant signs for a street section" do
    end
  end

  describe "#get_signs" do
    xit "should return relevant signs for a spot from both sides of street" do
    end
  end

    xit 'should identify correct signs' do
      expect(@spot.sign_description).to eq()
    end

end
