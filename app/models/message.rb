class Message

  def self.send_text_message(args)
    number_to_send_to = args[:number_to_send_to]
    body = args[:body]

    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body =>  body
    )
  end
end