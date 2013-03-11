Gem::Specification.new do |s|
  s.name        = 'email_regex'
  s.version     = '0.0.1'
  s.date        = '2013-03-11'
  s.license     = "MIT"
  s.summary     = "Validate email address regex"
  s.description = "Validate email address regex"
  s.authors     = ["Doug Wiegley"]
  s.email       = 'doug@parksidesoftware.com'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  
  s.homepage    = 'https://github.com/dougwig/email_regex.git'
end
