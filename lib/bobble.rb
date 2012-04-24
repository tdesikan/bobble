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
        Net::HTTP.get(URI.parse(url))
        puts "Successful!: #{url}"
      rescue Exception => e
        message = "FAILED!: #{url}"
        puts message

        if @@options[:twilio]
          TwilioReporter.report(message)
        end
        if @@options[:google_voice]
          GoogleVoiceReporter.report(message)
        end
        if @@options[:gmail]
          GmailReporter.report(message)
        end
      end
    end

  end
end

