# frozen_string_literal: true

require 'units/test_helper'

class Prawn::Emoji::ImageTest < Test::Unit::TestCase
  setup do
    @emoji_char = Object.new

    stub(@emoji_char).codepoint { 'emoji-codepoint' }
    stub(@emoji_char).width { 14 }
    stub(@emoji_char).height { 18 }

    @emoji_image = Prawn::Emoji::Image.new(@emoji_char)
  end

  test '#path' do
    assert_equal Prawn::Emoji::Image::STORE.join('emoji-codepoint.png').to_s, @emoji_image.path
  end

  test '#width' do
    assert_equal @emoji_char.width, @emoji_image.width
  end

  test '#height' do
    assert_equal @emoji_char.height, @emoji_image.height
  end

  test '#render' do
    document = Prawn::Document.new

    emoji_char = Prawn::Emoji::Char.new('🍣', 12)
    emoji_image = Prawn::Emoji::Image.new(emoji_char)

    position = { x: 100, y: 200 }

    mock(document).image(
      anything,
      at: [position[:x], position[:y] + emoji_char.height],
      width: emoji_char.width
    ).once

    emoji_image.render(document, at: position.values)
  end
end
