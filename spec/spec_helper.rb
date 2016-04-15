$:.unshift File.expand_path('../../lib', __FILE__)

require 'prawn'
require 'prawn/emoji'

require 'pdf/inspector'

require 'rspec'

def spec_cache_path
  File.expand_path '../../tmp', __FILE__
end

RSpec::configure do |spec|
  spec.before(:suite) do
    Prawn::EmojidexEmoji.init_emojidex spec_cache_path
    Prawn::EmojidexEmoji.cache
  end

  spec.after(:suite) { FileUtils.rm_r spec_cache_path }
end
