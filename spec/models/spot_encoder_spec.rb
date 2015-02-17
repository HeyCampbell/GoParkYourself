require 'rails_helper'

describe SpotEncoder do
  describe "when spot has a lat and a long" do
    let(:encodable){ OpenStruct.new(:latitude => 40.705765, :longitude => -74.007659)}

    it "it gets a main street set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.main_street.class).to be(String)
    end
    it "it gets a full address set on it" do
      SpotEncoder.new(encodable).encode!
      expect(encodable.full_address.class).to be(String)
    end
  end

  describe "when spot does not have a lat or long" do
    let(:not_encodable){ OpenStruct.new(:latitude => nil, :longitude => 500)}

    it "attempt to encode will raise an error" do
      expect{SpotEncoder.new(not_encodable).encode!}.to raise_error(NoMethodError)
    end
  end
end