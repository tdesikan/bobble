require 'bobble/checker'

module Bobble
  class << self

    # default options are guessed based on what environment variables are present
    @@options = {
      :twilio => !!ENV["BOBBLE_TWILIO_SID"],
      :google_voice => !!ENV["BOBBLE_GVOICE_USERNAME"],
      :gmail => !!ENV["BOBBLE_GMAIL_USERNAME"]
    }

    def option(key)
      @@options[key]
    end

    def check(url, options={})
      Bobble::Checker.check(url, options)
    end

  end
end


