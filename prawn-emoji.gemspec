require_relative 'lib/prawn/emoji/version'

Gem::Specification.new do |spec|
  spec.name          = 'prawn-emoji'
  spec.version       = Prawn::Emoji::VERSION
  spec.author        = 'Katsuya HIDAKA'
  spec.email         = 'hidakatsuya@gmail.com'

  spec.summary       = 'Adds Emoji support to Prawn'
  spec.description   = 'Prawn::Emoji is an extention that adds Emoji support to Prawn'
  spec.homepage      = 'https://github.com/hidakatsuya/prawn-emoji'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  end
  spec.require_path  = 'lib'

  spec.add_runtime_dependency 'prawn', '~> 2.2'
  spec.add_runtime_dependency 'unicode-emoji', '>= 2.5', '< 2.8'
end
