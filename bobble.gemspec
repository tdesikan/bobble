Gem::Specification.new do |s|
  s.name        = 'bobble'
  s.version     = '0.0.0'
  s.date        = '2012-04-24'
  s.summary     = "Bobble"
  s.description = "For freely pinging your favorite web services & freely or cheaply getting email/SMS notifications when they're down."
  s.authors     = ["Andrew Farmer"]
  s.email       = 'ahfarmer@gmail.com'
  s.files       = ["lib/bobble.rb"]
  s.homepage    = "https://github.com/ahfarmer/bobble"

  s.add_dependency('twilio', '>= 3.1.0')
end

