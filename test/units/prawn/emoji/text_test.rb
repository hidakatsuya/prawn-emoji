# frozen_string_literal: true

require 'units/test_helper'

class Prawn::Emoji::TextTest < Test::Unit::TestCase
  test 'Splitting text with an emoji' do
    emoji_text('left🍣remaining').tap do |text|
      assert_equal 'left', text.left
      assert_instance_of Prawn::Emoji::Char, text.emoji_char
      assert_equal '🍣', text.emoji_char.char
      assert_equal 12, text.emoji_char.font_size
      assert_equal 'remaining', text.remaining
    end

    emoji_text('no emoji').tap do |text|
      assert_equal 'no emoji', text.left
      assert_nil text.emoji_char
      assert_equal '', text.remaining
    end

    emoji_text('🎉').tap do |text|
      assert_equal '', text.left
      assert_equal '🎉', text.emoji_char.char
      assert_equal '', text.remaining
    end

    emoji_text('').tap do |text|
      assert_equal '', text.left
      assert_nil text.emoji_char
      assert_equal '', text.remaining
    end
  end

  test '#contains_emoji?' do
    assert_true emoji_text('👍').contains_emoji?
    assert_false emoji_text('text only').contains_emoji?
  end

  test '#left_with_emoji' do
    assert_equal 'aaaaaa📌', emoji_text('aaaaaa📌bbbbbb').left_with_emoji
    assert_equal 'aaaaaa', emoji_text('aaaaaa').left_with_emoji
  end

  test '#to_s' do
    assert_equal 'aaaaaa📌bbbbbb', emoji_text('aaaaaa📌bbbbbb').to_s
  end

  private

  def emoji_text(text)
    Prawn::Emoji::Text.new(text, 12)
  end
end
