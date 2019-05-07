rootdir = File.expand_path(File.dirname(__FILE__))

require "#{rootdir}/lib/prawn/emoji/version"

Gem::Specification.new do |spec|
  spec.name          = 'prawn-emoji'
  spec.version       = Prawn::Emoji::VERSION
  spec.author        = 'Katsuya HIDAKA'
  spec.email         = 'hidakatsuya@gmail.com'

  spec.summary       = 'Provides support for Emoji in Prawn'
  spec.description   = 'Prawn::Emoji is an extention for Prawn, provides feature for drawing Emoji.'
  spec.homepage      = 'https://github.com/hidakatsuya/prawn-emoji'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.4'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test}/*`.split("\n")
  spec.require_path  = 'lib'

  spec.add_runtime_dependency 'prawn', '>= 2.1.0'

  spec.add_development_dependency 'bundler', '>= 1.0.0'
  spec.add_development_dependency 'rake', '>= 0'
  spec.add_development_dependency 'minitest', '>= 0'
  spec.add_development_dependency 'rr', '>= 0'
  spec.add_development_dependency 'pdf-inspector', '>= 1.2.0'
end
