require 'rails_helper'

describe User do
  it "expects true to equal true" do
    expect(true).to eq true
  end

  it 'returns a User object' do
    expect(build(:user)).to be_a(User)
  end

  it 'has a name that is a string' do
    expect(build(:user)[:name]).to be_an_instance_of(String)
  end

  it 'has a oAuth expiry date that is an instance of ActiveSupport::TimeWithZone' do
    expect(build(:user)[:oauth_expires_at]).to be_an_instance_of(ActiveSupport::TimeWithZone)
  end

end
