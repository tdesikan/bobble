class Bobble
  class << self
    @@options = {
      :twilio => true,
      :google_voice => true,
      :gmail => true
    }

    def options(o)
      @@options.update(o)
    end

    def check(url)
      begin
        response = Net::HTTP.get(URI.parse(url))
        raise Exception.new("blank response") if response == ""
        puts "Successful!: #{url}"
      rescue Exception => e
        message = "FAILED!: #{url}"
        puts message

        if @@options[:twilio]
          TwilioNotifier.send(message)
        end
        if @@options[:google_voice]
          GoogleVoiceNotifier.send(message)
        end
        if @@options[:gmail]
          GmailNotifier.send(message)
        end
      end
    end

  end
end


require 'bobble/twilio_notifier'
require 'bobble/google_voice_notifier'
require 'bobble/gmail_notifier'


