require 'rake'

Gem::Specification.new do |s|
  s.name        = 'bobble'
  s.version     = '0.0.6'
  s.date        = '2012-07-06'
  s.summary     = "Bobble"
  s.description = "For pinging your web services (any URL) & freely or cheaply getting email/SMS notifications when they're down."
  s.authors     = ["Andrew Farmer"]
  s.email       = 'ahfarmer@gmail.com'
  s.files       = FileList["lib/bobble.rb", "lib/bobble/*", "lib/bobble/notifier/*"]
  s.homepage    = "https://github.com/ahfarmer/bobble"

  s.add_dependency('twilio-ruby', '>= 3.6.0')
  s.add_dependency('pony', '>= 1.4')

end

