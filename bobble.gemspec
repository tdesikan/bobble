require 'rake'

Gem::Specification.new do |s|
  s.name        = 'bobble'
  s.version     = '0.0.4'
  s.date        = '2012-04-24'
  s.summary     = "Bobble"
  s.description = "For pinging your web services (any URL) & freely or cheaply getting email/SMS notifications when they're down."
  s.authors     = ["Andrew Farmer"]
  s.email       = 'ahfarmer@gmail.com'
  s.files       = FileList["lib/bobble.rb", "lib/bobble/*"]
  s.homepage    = "https://github.com/ahfarmer/bobble"

  s.add_dependency('twilio-ruby', '>= 3.6.0')
  s.add_dependency('pony', '>= 1.4')

end

