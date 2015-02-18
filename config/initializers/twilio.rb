# config.middleware.use Rack::TwilioWebhookAuthentication, Rails.application.secrets.twilio_auth_token, '/messages'

twilio_sid = ENV['TWILIO_ACCOUNT_SID']
twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']

Twilio.configure do |config|
  config.account_sid = ENV['TWILIO_ACCOUNT_SID']
  config.auth_token = ENV['TWILIO_AUTH_TOKEN']
end

@client = Twilio::REST::Client.new(twilio_sid, twilio_auth_token)
