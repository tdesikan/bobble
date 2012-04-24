#
# Google Voice Notifier
# Adapted from: http://brettterpstra.com/sms-from-the-command-line-with-google-voice/
#

class Bobble::GoogleVoiceNotifier
  class << self

    def postit(uri_str, data, header = nil, limit = 3)
        raise ArgumentError, 'HTTP redirect too deep' if limit == 0
        url = URI.parse(uri_str)
        http = Net::HTTP.new(url.host,443)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        response,content = http.post(url.path,data,header)
        case response
          when Net::HTTPSuccess     then content
          when Net::HTTPRedirection then postit(response['location'],data,header, limit - 1)
          else
            puts response.inspect
            response.error!
        end
    end

    def getit(uri_str, header, limit = 3)
        raise ArgumentError, 'HTTP redirect too deep' if limit == 0
        url = URI.parse(uri_str)
        http = Net::HTTP.new(url.host,url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        response,content = http.get(url.path,header)
        case response
          when Net::HTTPSuccess     then content
          when Net::HTTPRedirection then getit(response['location'],header, limit - 1)
          else
            response.error!
        end
    end

    def send(message)
      message = Util.shorten_to_text_message(message)

      username = ENV["BOBBLE_GVOICE_USERNAME"]
      password = ENV["BOBBLE_GVOICE_PASSWORD"]
      # TODO: support multiple numbers
      number = ENV["BOBBLE_GVOICE_PHONENUMBER"]
      numbers = [number]

      data = "accountType=GOOGLE&Email=#{username}&Passwd=#{password}&service=grandcentral&source=brettterpstra-CLISMS-2.0"
      res = postit('https://www.google.com/accounts/ClientLogin',data)

      if res
        authcode = res.match(/Auth=(.+)/)[1]
        header = {'Authorization' => "GoogleLogin auth=#{authcode.strip}",'Content-Length' => '0'}
        newres = getit('https://www.google.com/voice',header)

        if newres
          rnrse = newres.match(/'_rnr_se': '([^']+)'/)[1]
          numbers.each do |num|
            data = "_rnr_se=#{rnrse}&phoneNumber=#{num.strip}&text=#{message}&id="
            finalres = postit('https://www.google.com/voice/sms/send/',data,header)

            if finalres["ok"]
              puts "Message sent to #{num}"
            else
              puts "Error sending to #{num}"
            end
          end

        else
          newres.error!
        end

      else
        res.error!
      end
    end

  end
end
