require 'rails_helper'
require 'factory_girl_rails'

describe "Spot" do
  let(:spot) { Spot.new(lat: 40.705765, long: -74.007659, remind?: true )}
  let(:street) { FactoryGirl.create(:street_section) }

  xit "should initialize with GPS coordinates" do
    expect(spot.lat).to eq(40.705765)
  end

  xit 'should identify the appropriate street section' do
    expect(spot.street_section.status_order).to eq(street.status_order)

  end

  xit 'should identify correct sign' do
    expect(spot.sign_description).to eq()
  end
end
