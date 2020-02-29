# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Drawer do
  let(:document) { Prawn::Document.new }
  let(:drawer) { Prawn::Emoji::Drawer.new(document) }

  before do
    document.font Prawn::Emoji.root.join 'test', 'fonts', 'DejaVuSans.ttf'
  end

  subject { drawer.draw(text, text_options) }

  describe 'skip drawing' do
    let(:text_options) { {} }

    describe 'text is not utf8' do
      let(:text) { 'a'.encode('ascii-8bit') }
      it { _(subject).must_be_same_as text }
    end

    describe 'text does not include emoji' do
      let(:text) { 'abcdefg' }
      it { _(subject).must_be_same_as text }
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
        mock(document).image(is_a(File), at: position, width: sushi_image.width).once
      end
      subject
    end

    it 'returns text that all emoji has substituted' do
      _(subject).must_equal "aaa#{sub_char}bbb#{sub_char}#{sub_char}ccc"
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
      _(subject).must_equal text
    end
  end

  describe 'text is empty' do
    let(:text) { '' }
    let(:text_options) { {} }

    it { _(subject).must_be_same_as text }
  end

  describe 'preserve the original text' do
    let(:text_options) { { at: [100, 200], font_size: 12 } }
    let(:sub_char) { Prawn::Emoji::Substitution.new(document).to_s }

    let(:emojis) { '🍣👨‍👨‍👦' }

    describe 'ASCII Character' do
      let(:ascii_33_79) { (33..79).map(&:chr).join }
      let(:ascii_80_126) { (80..126).map(&:chr).join }
      let(:text) {
        [emojis, ascii_33_79, emojis, ascii_80_126, emojis].join
      }
      it { _(subject).must_equal [sub_char * 2, ascii_33_79, sub_char * 2, ascii_80_126, sub_char * 2].join }
    end

    describe 'Textual Emoji' do
      let(:textual_emoji) { '▶' }
      let(:emoji_with_text_presentation) { "\u{1f634}\u{FE0E}" }
      let(:text) {
        [
          emojis, textual_emoji, emoji_with_text_presentation,
          emojis, textual_emoji, emoji_with_text_presentation, emojis
        ].join
      }
      it do
        _(subject).must_equal [
          sub_char * 2, textual_emoji, emoji_with_text_presentation,
          sub_char * 2, textual_emoji, emoji_with_text_presentation, sub_char * 2
        ].join
      end
    end

    describe 'CJK' do
      let(:japanese) { 'あいうえお日本語￥〇〒' }
      let(:text) { [emojis, japanese, emojis, japanese, emojis].join }

      it { _(subject).must_equal [sub_char * 2, japanese, sub_char * 2, japanese, sub_char * 2].join }
    end
  end

  describe 'Closing opened image files' do
    let(:text) { '🍣' }
    let(:text_options) { { at: [100, 200], font_size: 12 } }

    it do
      opened_files = { before: count_opened_files, after: nil }

      disable_gc {
        subject
        opened_files[:after] = count_opened_files
      }

      _(opened_files[:after]).must_equal opened_files[:before]
    end

    def count_opened_files
      ObjectSpace.each_object(File).reject(&:closed?).count
    end

    def disable_gc
      was_disabled = GC.disable
      begin
        yield
      ensure
        GC.enable unless was_disabled
      end
    end
  end
end
