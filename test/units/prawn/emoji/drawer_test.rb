# frozen_string_literal: true

require 'units/test_helper'

class Prawn::Emoji::DrawerTest < Test::Unit::TestCase
  setup do
    @font_size = 12
    @text_options = { at: [100, 200], font_size: @font_size }

    @document = Prawn::Document.new.tap do |doc|
      doc.font Prawn::Emoji.root.join 'test', 'fonts', 'DejaVuSans.ttf'
      doc.font_size @font_size
    end

    @drawer = Prawn::Emoji::Drawer.new(@document)
  end

  test 'Supported emojis should be drawn' do
    text = "aaa🍣bbb🍣🍣ccc"

    mock(@document).draw_text!(/aaa|bbb|ccc|/, hash_including(emoji: false)).times(4)
    mock.proxy(Prawn::Emoji::Image).new.with_any_args.times(3)

    @drawer.draw(text, @text_options)
  end

  test 'Unsupported emojis should not be drawn' do
    text = '😴︎ is not supported'

    mock(@document).draw_text!(text, @text_options.merge(emoji: false)).once
    mock(Prawn::Emoji::Image).new.with_any_args.never

    @drawer.draw(text, @text_options)
  end

  test 'Emojis for which no image exists should not be drawn as emojis' do
    text = "aaa🍣bbb🍣"

    # Always returns false for the check if an emoji image exists
    stub(@drawer.send(:emoji_index)).include? { false }

    mock(@document).draw_text!('aaa🍣', is_a(Hash)).once
    mock(@document).draw_text!('bbb🍣', is_a(Hash)).once
    mock(@document).draw_text!('', is_a(Hash)).once

    # The process of drawing emoji images is never called
    mock(@drawer).draw_emoji.with_any_args.never

    @drawer.draw(text, @text_options)
  end

  sub_test_case 'Opened image file descriptor' do
    test 'The file descriptors should be closed' do
      opened_files = { before: count_opened_files, after: nil }

      disable_gc {
        @drawer.draw('🍣', @text_options)
        opened_files[:after] = count_opened_files
      }

      assert_equal opened_files[:before], opened_files[:after]
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

  sub_test_case 'Internal methods' do
    setup { stub(@document).character_spacing { 3 } }

    test '#draw_emoji returns the character width including the character spacing' do
      sushi_char = Prawn::Emoji::Char.new('🍣', @font_size)
      assert_equal sushi_char.width + 3, @drawer.send(:draw_emoji, sushi_char, at: [100, 200])
    end

    test '#draw_text returns 0 when the text is empty' do
      assert_equal 0, @drawer.send(:draw_text, '', at: [100, 200], text_options: @text_options)
    end

    test '#draw_text returns the text width including the character spacing at the end of the text' do
      text = 'text'

      assert_equal @document.width_of(text) + @document.character_spacing,
        @drawer.send(:draw_text, text, at: [100, 200], text_options: @text_options)
    end
  end
end
