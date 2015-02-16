require 'rails_helper'
require 'factory_girl_rails'

describe "Street Section" do

  let(:street) { FactoryGirl.create(:street_section) }

  it "has a valid FACTORY" do
    expect(FactoryGirl.create(:street_section)).to be_valid
  end

  xit 'should be associated with a status order' do
    expect(street.status_order).to_not
  end

  it "should have a main street" do
    expect(street.main_street).to eq('PEARL STREET')
  end

  xit "should calculate GPS of cross streets when created" do
    expect(street.from_lat).to eq(40.7060419)
  end

  xit "should calculate length of street section rounded to nearest feet" do
    expect(street.length).to eq(229)
  end
end

