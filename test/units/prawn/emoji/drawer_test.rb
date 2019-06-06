# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Drawer do
  let(:document) { Prawn::Document.new }
  let(:drawer) { Prawn::Emoji::Drawer.new document: document }

  before do
    document.font Prawn::Emoji.root.join 'test', 'fonts', 'DejaVuSans.ttf'
  end

  subject { drawer.draw(text, text_options) }

  describe 'skip drawing' do
    let(:text_options) { {} }

    describe 'text is not utf8' do
      let(:text) { 'a'.encode('ascii-8bit') }
      it { subject.must_be_same_as text }
    end

    describe 'text does not include emoji' do
      let(:text) { 'abcdefg' }
      it { subject.must_be_same_as text }
    end
  end

  describe 'text that contains supported emojis' do
    let(:sushi) { '🍣' }
    let(:sushi_unicode) { Prawn::Emoji::Unicode.new(sushi) }
    let(:sushi_image) { Prawn::Emoji::Image.new(sushi_unicode, 12) }
    let(:text_options) { { at: [100, 200], font_size: 12 } }
    let(:sub_char) { Prawn::Emoji::Substitution.new(document) }

    let(:text) { "aaa#{sushi}bbb#{sushi}#{sushi}ccc" }

    it 'draws alternative images for each emoji included in the text' do
      image_x_positions = [
        100 + document.width_of('aaa', text_options),
        100 + document.width_of("aaa#{sub_char}bbb", text_options),
        100 + document.width_of("aaa#{sub_char}bbb#{sub_char}", text_options)
      ]

      image_x_positions.each do |x|
        position = [
          sushi_image.adjust_x(x),
          sushi_image.adjust_y(200)
        ]
        mock(document).image(sushi_image.path, at: position, width: sushi_image.width).once
      end
      subject
    end

    it 'returns text that all emoji has substituted' do
      subject.must_equal "aaa#{sub_char}bbb#{sub_char}#{sub_char}ccc"
    end
  end

  describe 'text that contains unsupported emojis' do
    let(:text) { '😴︎ is not supported' }
    let(:text_options) { { at: [100, 200], font_size: 12 } }

    it 'does not draw emoji' do
      mock(document).image.never
      subject
    end

    it 'returns the original text' do
      subject.must_equal text
    end
  end

  describe 'empty text' do
    let(:text) { '' }
    let(:text_options) { {} }

    it { subject.must_be_same_as text }
  end
end
