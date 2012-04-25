class Bobble
  class << self

    # default options are guessed based on what environment variables are present
    @@options = {
      :twilio => !!ENV["BOBBLE_TWILIO_SID"],
      :google_voice => !!ENV["BOBBLE_GVOICE_USERNAME"],
      :gmail => !!ENV["BOBBLE_GMAIL_USERNAME"]
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

        send_notification(message, url)
      end
    end

    def send_notification(message, url)

      if @@options[:gmail]
        begin
          GmailNotifier.send(message, url)
        rescue Exception => e
          puts "Gmail Notifier failed: #{e.message}"
        end
      end

      if @@options[:twilio]
        begin
          TwilioNotifier.send(message)
        rescue Exception => e
          puts "Twilio Notifier failed: #{e.message}"
        end
      end

      if @@options[:google_voice]
        begin
          GoogleVoiceNotifier.send(message)
        rescue Exception => e
          puts "Google Voice Notifier failed: #{e.message}"
        end
      end

    end

  end
end

require 'bobble/twilio_notifier'
require 'bobble/google_voice_notifier'
require 'bobble/gmail_notifier'


