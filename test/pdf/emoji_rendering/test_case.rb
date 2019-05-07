# frozen_string_literal: true

require 'pdf/test_helper'

module EmojiRendering
  class TestCase < PdfTest
    set_case_name :emoji_rendering

    def test_pdf
      Pdf.generate(actual_pdf) do |pdf|
        pdf.section 'Singleton Emoji' do
          pdf.emoji '🍣'
          pdf.emoji '😴'
        end

        pdf.section 'Emoji/Text Presentation' do
          pdf.emoji '⌛', desc: 'Emoji without variation'
          pdf.emoji '⌛︎', desc: 'Emoji with Text variation'
          pdf.emoji '⌛️', desc: 'Emoji with Emoji variation'
          pdf.emoji '™', desc: 'Textual Emoji without variation'
          pdf.emoji '™︎', desc: 'Textual Emoji with Text variation'
          pdf.emoji '™️', desc: 'Textual Emoji with Emoji variation'
        end

        pdf.section 'Emoji Combining Sequence' do
          pdf.emoji '1️⃣'
        end

        pdf.section 'Emoji Modifier Sequence' do
          pdf.emojis %w( 👏 👏🏻 👏🏼 👏🏽 👏🏾 👏🏿 )
        end

        pdf.section 'Emoji Flag Sequence' do
          pdf.emojis %w( 🇯🇵 🇺🇸 )
        end

        pdf.section 'Emoji ZWJ Sequence' do
          pdf.emojis %w(👩‍✈️ 👩🏾‍✈️)
          pdf.emoji '👨‍👨‍👦'
          pdf.emoji '🚵🏼‍♀️'
          pdf.emoji '🏳️‍🌈'
        end

        pdf.section 'Non-Emoji' do
          pdf.text '1234567890#*'
        end
      end

      assert_match_pdf
    end
  end
end
