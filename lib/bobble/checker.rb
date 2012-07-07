require 'bobble/notifier/twilio'
require 'bobble/notifier/google_voice'
require 'bobble/notifier/gmail'

module Bobble
  class Checker
    class << self

      def check(url)
        begin
          response = Net::HTTP.get(URI.parse(url))
          raise Exception.new("empty response") if response == ""
          puts "Successful!: #{url}"
        rescue Exception => e
          message = "FAILED: #{url} - #{e.message}"
          puts message

          self.send_notification(message, url)
        end
      end

      def send_notification(message, url)
        if @@options[:gmail]
          begin
            Notifier::Gmail.send(message, url)
          rescue Exception => e
            puts "Gmail Notifier failed: #{e.message}"
          end
        end

        if @@options[:twilio]
          begin
            Notifier::Twilio.send(message)
          rescue Exception => e
            puts "Twilio Notifier failed: #{e.message}"
          end
        end

        if @@options[:google_voice]
          begin
            Notifier::GoogleVoice.send(message)
          rescue Exception => e
            puts "Google Voice Notifier failed: #{e.message}"
          end
        end
      end

    end
  end
end
