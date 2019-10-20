# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    let(:emojis) { %w( 😀 © 🇯🇵 ) }
    let(:emoji_unicodes) { emojis.map { |emoji| Prawn::Emoji::Unicode.new(emoji) } }

    it 'possible to find the image file' do
      emoji_unicodes.each do |emoji_unicode|
        emoji_image = Prawn::Emoji::Image.new(emoji_unicode, 12)
        assert File.exist?(emoji_image.path), "#{emoji_unicode}  not found"
      end
    end
  end

  describe '#adjust_x' do
    subject { Prawn::Emoji::Image.new('🍣', 12).adjust_x(100) }
    it { _(subject).must_equal 100.9 }
  end

  describe '#adjust_y' do
    subject { Prawn::Emoji::Image.new('❤', 18).adjust_y(100) }
    it { _(subject).must_equal 114.4 }
  end

  describe '#width' do
    subject { Prawn::Emoji::Image.new('❤', 10).width }
    it { _(subject).must_equal 8.5 }
  end
end
