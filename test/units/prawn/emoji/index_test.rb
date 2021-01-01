# frozen_string_literal: true

require 'units/test_helper'
require 'yaml'

class Prawn::Emoji::IndexTest < Test::Unit::TestCase
  setup { @emoji_index = Prawn::Emoji::Index.new }

  test '#codepoints' do
    all_emoji_codepoints = YAML.load_file(Prawn::Emoji.root.join('emoji', 'index.yml'))
    assert_equal all_emoji_codepoints, @emoji_index.codepoints
  end

  test '#include?' do
    assert_true @emoji_index.include?('0023-20e3')
    assert_true @emoji_index.include?('3299')
    assert_false @emoji_index.include?('unknown-codepoint')
  end
end
