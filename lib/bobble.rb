require 'bobble/checker'

module Bobble
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
      Bobble::Checker.check(url)
    end

  end
end

require 'bobble/twilio_notifier'
require 'bobble/google_voice_notifier'
require 'bobble/gmail_notifier'


