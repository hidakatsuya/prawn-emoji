# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    let(:emojis) { %w( 😀 © 🇯🇵 ) }
    let(:emoji_chars) { emojis.map { |emoji| Prawn::Emoji::Char.new(emoji, 12) } }

    it 'possible to find the image file' do
      emoji_chars.each do |emoji_char|
        emoji_image = Prawn::Emoji::Image.new(emoji_char)
        assert File.exist?(emoji_image.path), "#{emoji_char}  not found"
      end
    end
  end
end
