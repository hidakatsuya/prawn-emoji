# frozen_string_literal: true

require 'units/test_helper'

class Prawn::EmojiTest < Test::Unit::TestCase
  test '.regex' do
    # Default
    assert_equal ::Unicode::Emoji::REGEX_VALID, Prawn::Emoji.regex

    Prawn::Emoji.config.regex = ::Unicode::Emoji::REGEX_INCLUDE_TEXT
    assert_equal ::Unicode::Emoji::REGEX_INCLUDE_TEXT, Prawn::Emoji.regex
  ensure
    Prawn::Emoji.config.regex = ::Unicode::Emoji::REGEX_VALID
  end
end
