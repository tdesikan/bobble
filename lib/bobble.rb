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
        raise Exception.new("empty response") if response == ""
        puts "Successful!: #{url}"
      rescue Exception => e
        message = "FAILED: #{url} - #{e.message}"
        puts message

        send_notification(message)
      end
    end

    def send_notification(message)
      if @@options[:gmail]
        GmailNotifier.send(message)
      end

      text_message = message
      if message.length > 140
        text_message = message[0..136] + "..."
      end
      if @@options[:twilio]
        TwilioNotifier.send(text_message)
      end
      if @@options[:google_voice]
        GoogleVoiceNotifier.send(text_message)
      end

    end

  end
end


require 'bobble/twilio_notifier'
require 'bobble/google_voice_notifier'
require 'bobble/gmail_notifier'


