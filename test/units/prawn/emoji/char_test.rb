# frozen_string_literal: true

require 'units/test_helper'

class Prawn::Emoji::CharTest < Test::Unit::TestCase
  test '.format_codepoint' do
    [
      [%w(abcd), 'abcd'],
      [%w(ABCD), 'abcd'],
      [%w(a), '000a'],
      [%w(1234 5678 9012), '1234-5678-9012'],
      [%w(A B C), '000a-000b-000c']
    ].each do |(args, expect)|
      assert_equal expect, Prawn::Emoji::Char.format_codepoint(args)
    end
  end

  test '#==' do
    assert_true emoji_char('🐟') == emoji_char('🐟')
    assert_false emoji_char('🐟') == emoji_char('🍣')
  end

  test '#codepoint' do
    assert_equal '1f363', emoji_char('🍣').codepoint
    assert_equal '1f1ef-1f1f5', emoji_char('🇯🇵').codepoint
  end

  test '#to_s' do
    assert_equal '🍣', emoji_char('🍣').to_s
    assert_equal "\u2764\ufe0f", emoji_char('❤️').to_s
  end

  test '#width' do
    emoji_char('🍣').tap do |char|
      assert_equal char.font_size * 0.85, char.width
    end
  end

  test '#height' do
    emoji_char('🍣').tap do |char|
      assert_equal char.font_size * 0.8, char.height
    end
  end

  test 'Removing all variation selectors' do
    # An emoji with no selector
    assert_equal '2600', emoji_char("\u2600").codepoint

    # An emoji with text presentation selector
    assert_equal '2600', emoji_char("\u2600\ufe0e").codepoint

    # An emoji with emoji presentation selector
    assert_equal '2600', emoji_char("\u2600\ufe0f").codepoint
  end

  private

  def emoji_char(emoji, font_size = 12)
    Prawn::Emoji::Char.new(emoji, font_size)
  end
end
