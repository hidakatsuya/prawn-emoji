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

  describe '#width and #height' do
    let(:emoji_image) { Prawn::Emoji::Image.new(emoji_char) }
    let(:emoji_char) { Prawn::Emoji::Char.new('🍣', 12) }

    before do
      stub(emoji_char).width { 14 }
      stub(emoji_char).height { 18 }
    end

    it do
      _(emoji_image.width).must_equal 14
      _(emoji_image.height).must_equal 18
    end
  end

  describe '#render' do
    let(:emoji_image) { Prawn::Emoji::Image.new(Prawn::Emoji::Char.new('🍣', 12)) }

    it do
      document = Prawn::Document.new

      mock(document).image.with_any_args.times(1)

      emoji_image.render(document, at: [100, 200])
    end
  end
end
