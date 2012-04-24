require 'twilio-ruby'

class Bobble::TwilioNotifier
  class << self

    @@client = nil

    def create_client
      return if @@client

      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_TOKEN']

      @@client = Twilio::REST::Client.new account_sid, auth_token
    end
    
    def send(message)
      create_client

      params = {
        :from => ENV['TWILIO_PHONENUMBER'],
        :to => ENV['MY_PHONENUMBER'],
        :body => message
      }
      @@client.account.sms.messages.create(params)
    end

  end
end
