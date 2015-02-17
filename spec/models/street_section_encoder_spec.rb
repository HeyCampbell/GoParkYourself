require 'rails_helper'

describe "StreetSectionEncoder" do

  describe "when a street section has a main street and side street" do
    let(:encodable){ OpenStruct.new(main_street: "WALL STREET", to_street: "WILLIAM STREET", from_street: "PINE STREE")}

    it "it gets a from point set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.point_to.class).to be(Array)
    end

    it "it gets a from point set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.point_to.length).to eq(2)
    end

    it "it gets a from point set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.point_from[0]).to be(Fixnum)
    end

    it "it gets a to point set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.point_to[1]).to be(Fixnum)
    end
  end

  describe "when spot does not have a lat or long" do
    let(:not_encodable){ OpenStruct.new(:latitude => nil, :longitude => 500)}

    it "attempt to encode will raise an error" do
      expect{SpotEncoder.new(not_encodable).encode!}.to raise_error(NoMethodError)
    end

  end
end