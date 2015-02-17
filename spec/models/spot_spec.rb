require 'rails_helper'
require 'factory_girl_rails'
# require 'byebug'

describe Spot do
   let(:created_spot) { Spot.create(latitude: 40.705765, longitude: -74.007659, remind?: true )}
   let(:sections) {created_spot.get_street_sections}
   let(:intersection) {created_spot.nearest_intersection}

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

    xit "should return two street sections" do
      expect(sections.count).to eq(2)
    end

    xit "should return street section with same mainstreet as spot" do
      spot_street_name = created_spot.main_street.upcase
      section_street_name = sections[0].main_street.upcase
      expect(section_street_name.include?(spot_street_name) || spot_street_name.include?(section_street_name)).to eq(true)
    end

    xit "should return street section with same mainstreet as spot" do
      spot_street_name = created_spot.main_street.upcase
      section_street_name = sections[1].main_street.upcase
      expect(section_street_name.include?(spot_street_name) || spot_street_name.include?(section_street_name)).to eq(true)
    end
  end

  describe "#get_signs_for(section)" do
    let(:section) {sections[0]}
    let(:signs) {created_spot.get_signs_for(section)}

    xit "should return sign objects for a street section" do
      expect(signs[0].class).to eq(Sign)
    end

    xit "should return signs that belong to that street section" do
      expect(signs[1].street_section).to eq(section)
    end

    xit "should return signs near the spot" do
      distance = StreetSection.get_distance_in_feet([created_spot.latitude, created_spot.longitude], section.point_from) - section.buffer
      expect((distance - signs[0].distance).abs < 10).to eq(true)
    end
  end

  describe "#get_signs" do
    let(:section) {sections[0]}
    let(:signs) {created_spot.get_signs}

    xit "should return sign objects" do
      byebug
      expect(created_spot.get_signs[1].class).to eq(Sign)
    end

    it "should return relevant signs for a spot from both sides of street" do

    end

     xit 'should identify correct signs' do
      expect(@spot.sign_description).to eq()
    end
  end

end
