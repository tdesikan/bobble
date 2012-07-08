require 'bobble/notifier/twilio'
require 'bobble/notifier/google_voice'
require 'bobble/notifier/gmail'

module Bobble
  class Checker
    class << self

      def check(url, options={})
        {
          # The status that is considered a success.
          # If nil, any status other than 50x is success.
          :success_status => nil,
          # Specified headers are required for the response
          # to be considered a success.
          # Regex values can be specified.
          :success_header => nil,
          # Response body must match the specified body.
          # Can be a regex.
          :success_body => nil
        }.update(options)

        begin
          response = http_request(url)
          assert_success(response, options)
          puts "Successful!: #{url}"
        rescue Exception => e
          message = "FAILED: #{url} - #{e.message}"
          puts message

          self.send_notification(message, url)
        end
      end

      def http_request(url)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        return http.request(request)
      end

      # raises an exception if not successful
      def assert_success(response, options)

        if options[:success_status]
          unless response.code.to_i == options[:success_status].to_i
            raise Exception.new("Response status code error. Is: #{response.code} Expected: #{options[:success_status]}")
          end
        elsif response.code.to_i >= 500
          raise Exception.new("Response status code error: #{response.code}")
        end

        if options[:success_header]
          options[:success_header].each do |k,v|
            header_value = response.header[k.to_s]
            if v.is_a?(Regexp)
              unless header_value =~ v
                raise Exception.new("Response header '#{k}' should match regexp #{v} ('#{header_value}' does not match)")
              end
            else
              unless header_value == v
                raise Exception.new("Response header '#{k}' should have value '#{v}' (instead is #{header_value})")
              end
            end
          end
        end

        if options[:success_body]
          match = options[:success_body]
          if match.is_a?(Regexp)
            unless response.body =~ match
              raise Exception.new("Response body should match regexp #{match}, but does not.")
            end
          else
            unless response.body.strip == match.strip
              raise Exception.new("Response body should be '#{match}', instead is '#{response.body}'")
            end
          end
        end

      end

      def send_notification(message, url)
        if Bobble.option(:gmail)
          begin
            Notifier::Gmail.send(message, url)
          rescue Exception => e
            puts "Gmail Notifier failed: #{e.message}"
          end
        end

        if Bobble.option(:twilio)
          begin
            Notifier::Twilio.send(message)
          rescue Exception => e
            puts "Twilio Notifier failed: #{e.message}"
          end
        end

        if Bobble.option(:google_voice)
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
