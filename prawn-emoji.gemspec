lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'prawn/emoji/version'

Gem::Specification.new do |spec|
  spec.name          = 'prawn-emoji'
  spec.version       = Prawn::Emoji::VERSION
  spec.authors       = ['Katsuya HIDAKA']
  spec.email         = ['hidakatsuya@gmail.com']

  spec.summary       = 'Provides support for Emoji in Prawn'
  spec.homepage      = 'https://github.com/hidakatsuya/prawn-emoji'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'prawn', '>= 1.3.0'

  spec.add_development_dependency 'bundler', '>= 1.0.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rr'
  spec.add_development_dependency 'pdf-inspector'
end
