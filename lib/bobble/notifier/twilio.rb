require 'twilio-ruby'
require 'bobble/util'

module Bobble
  module Notifier
    class Twilio
      class << self

        @@client = nil

        def create_client
          return if @@client

          account_sid = ENV['BOBBLE_TWILIO_SID']
          auth_token = ENV['BOBBLE_TWILIO_TOKEN']

          @@client = Twilio::REST::Client.new account_sid, auth_token
        end
        
        def send(message)
          create_client
          message = Bobble::Util.shorten_to_text_message(message)

          params = {
            :from => ENV['BOBBLE_TWILIO_FROM_PHONENUMBER'],
            :to => ENV['BOBBLE_TWILIO_TO_PHONENUMBER'],
            :body => message
          }
          @@client.account.sms.messages.create(params)
        end

      end
    end
  end
end
