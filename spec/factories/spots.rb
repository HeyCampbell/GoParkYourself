FactoryGirl.define do
  factory :spot do
    latitude 40.705765
    longitude -74.007659
    sign_id
    user_id 1
    parked_at
    remind? true
    expiration '3 HOUR PARKING 6PM-10PM MON THRU FRI 10AM-10PM SATURDAY W/ SINGLE ARROW'
  end
end

