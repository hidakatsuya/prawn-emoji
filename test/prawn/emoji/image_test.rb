# frozen_string_literal: true

require 'test_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    let(:emojis) { %w( 😀 © 🇯🇵 ) }
    let(:emoji_unicodes) { emojis.map { |emoji| Prawn::Emoji::Unicode.new(emoji) } }

    it 'possible to find the image file' do
      emoji_unicodes.each do |emoji_unicode|
        emoji_image = Prawn::Emoji::Image.new(emoji_unicode)
        assert File.exist?(emoji_image.path), "#{emoji_unicode}  not found"
      end
    end
  end

  describe '#==' do
    it { Prawn::Emoji::Image.new('🍣').must_be :==, Prawn::Emoji::Image.new('🍣') }
    it { Prawn::Emoji::Image.new('🍣').wont_be :==, Prawn::Emoji::Image.new('🐟') }
  end
end
