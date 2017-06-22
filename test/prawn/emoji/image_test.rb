# frozen_string_literal: true

require 'test_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    let(:emojis) { %w( 😀 © 🇯🇵 ) }

    it 'possible to find the image file' do
      emojis.each do |emoji|
        emoji_image = Prawn::Emoji::Image.new(emoji)
        assert File.exist?(emoji_image.path), "#{emoji}  not found"
      end
    end
  end

  describe '#==' do
    it { Prawn::Emoji::Image.new('🍣').must_be :==, Prawn::Emoji::Image.new('🍣') }
    it { Prawn::Emoji::Image.new('🍣').wont_be :==, Prawn::Emoji::Image.new('🐟') }
  end
end
