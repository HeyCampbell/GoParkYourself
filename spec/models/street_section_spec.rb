require 'rails_helper'
require 'factory_girl_rails'

describe "Street Section" do

  let(:street) { FactoryGirl.create(:street_section) }

  it "has a valid FACTORY" do
    expect(FactoryGirl.create(:street_section)).to be_valid
  end

  # it 'should be associated with a status order' do
  #   expect(street.status_order).to_not
  # end

  it "should have a main street" do
    expect(street.main_street).to be_valid
  end

  it "should calculate GPS of cross streets when created" do
    expect(street.from_lat).to eq("Biggie_Smalls")
  end


end