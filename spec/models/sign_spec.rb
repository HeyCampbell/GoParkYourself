require 'rails_helper'
require 'factory_girl_rails'

# describe "Sign" do

#   xit "should be associated with street section" do

#   end


# end

describe "no_parking_times" do

  let(:sign1){Sign.create(status_order: 'P-051496', sign_sequence: 20, distance: 1124, arrow: 'N', sign_description: "NO PARKING ANYTIME (ARROW) (SUPERSEDED BY R7-40RA DON'T USE R7-40A)")}
  it "Should return a hash of hashes" do
    expect(sign1.no_parking_times.first.class).to eq(Hash)
  end



end
