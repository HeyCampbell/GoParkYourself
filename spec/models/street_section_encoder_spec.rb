require 'rails_helper'

describe "StreetSectionEncoder" do

  describe "when a street section has a main street and side street" do
    let(:street_section_encodable){ OpenStruct.new(main_street: "WALL STREET", to_street: "WILLIAM STREET", from_street: "PINE STREE")}

    it "it gets a from point set on it" do
      StreetSectionEncoder.new(street_section_encodable).encode!
      expect(street_section_encodable.longitude_to.class).to be(Float)
    end

    it "it gets a from point set on it" do
      StreetSectionEncoder.new(street_section_encodable).encode!
      expect(street_section_encodable.latitude_to.class).to eq(Float)
    end
  end

  describe "when a street section does not have a main street" do
    let(:not_encodable){ OpenStruct.new(to_street: "WILLIAM STREET", from_street: "PINE STREET")}

    it "will not have its to_street intersection encoded with a latitude" do
      StreetSectionEncoder.new(not_encodable).encode!
      expect(not_encodable.latitude_to).to be(nil)
    end

    it "will not have its to_street intersection encoded with a longitude" do
      StreetSectionEncoder.new(not_encodable).encode!
      expect(not_encodable.longitude_to).to be(nil)
    end
  end
end