module Bobble
  class Util
    class << self

      def shorten_to_text_message(message)
        text_message = message
        if message.length > 140
          text_message = message[0..136] + "..."
        end
        return message
      end

    end
  end
end
