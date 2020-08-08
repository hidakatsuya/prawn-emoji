# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Drawer do
  let(:document) { Prawn::Document.new }
  let(:drawer) { Prawn::Emoji::Drawer.new(document) }
  let(:font_size) { 12 }

  before do
    document.font Prawn::Emoji.root.join 'test', 'fonts', 'DejaVuSans.ttf'
    document.font_size = font_size
  end

  subject { drawer.draw(text, text_options) }

  describe 'text with supported emojis' do
    let(:sushi) { '🍣' }
    let(:sushi_char) { Prawn::Emoji::Char.new(sushi, font_size) }
    let(:sushi_image) { Prawn::Emoji::Image.new(sushi_char) }
    let(:text_options) { { at: [100, 200], font_size: font_size} }

    let(:text) { "aaa#{sushi}bbb#{sushi}#{sushi}ccc" }

    it do
      mock(document).draw_text!(/aaa|bbb|ccc|/, hash_including(emoji: false)).times(4)
      any_instance_of(Prawn::Emoji::Image) { |image| mock(image).render.with_any_args.times(3) }

      subject
    end
  end

  describe 'text with unsupported emoji' do
    let(:text) { '😴︎ is not supported' }
    let(:text_options) { { at: [100, 200], font_size: 12 } }

    it do
      mock(document).draw_text!(text, text_options.merge(emoji: false)).once
      any_instance_of(Prawn::Emoji::Image) { |image| mock(image).render.with_any_args.never }

      subject
    end
  end

  describe 'closing opened image files' do
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

  describe 'internal methods' do
    describe '#draw_emoji' do
      subject { drawer.send(:draw_emoji, sushi_char, at: [100, 200]) }

      let(:sushi_char) { Prawn::Emoji::Char.new('🍣', font_size) }

      it 'returns the character width' do
        stub(document).character_spacing { 3 }
        _(subject).must_equal sushi_char.width + 3
      end
    end

    describe '#draw_text' do
      subject { drawer.send(:draw_text, text, at: [100, 200], text_options: {}) }

      let(:character_spacing) { 5 }

      before { stub(document).character_spacing { character_spacing } }

      describe 'text is empty' do
        let(:text) { '' }

        it 'returns 0 when the text is empty' do
          _(subject).must_equal 0
        end
      end

      describe 'text is not empty' do
        let(:text) { 'text' }

        it 'returns the text width including the character spacing at the end of the text' do
          expect_width =
            if Prawn::VERSION >= '2.3.0'
              document.width_of(text) + character_spacing
            else
              document.width_of(text)
            end

          _(subject).must_equal expect_width
        end
      end
    end
  end
end
