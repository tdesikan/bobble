require 'pony'

class Bobble::GmailNotifier
  class << self

    def send(message, url)
      Pony.mail({
                  :to => ENV["BOBBLE_GMAIL_TO"],
                  :via => :smtp,
                  :via_options => {
                    :address              => 'smtp.gmail.com',
                    :port                 => '587',
                    :enable_starttls_auto => true,
                    :user_name            => ENV["BOBBLE_GMAIL_USERNAME"],
                    :password             => ENV["BOBBLE_GMAIL_PASSWORD"],
                    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
                  },
                  :body => message,
                  :subject => "Bobble: #{url} is down"
                })
    end

  end
end
