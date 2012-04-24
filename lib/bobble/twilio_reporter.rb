require 'twilio-ruby'

class Bobble::TwilioReporter
  class << self

    def report(message)
      params = {
        :from => ENV['TWILIO_PHONENUMBER'],
        :to => ENV['MY_PHONENUMBER'],
        :body => message
      }
      @@client.account.sms.messages.create(params)
    end

  end
end
