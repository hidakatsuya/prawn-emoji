# frozen_string_literal: true

require_relative 'substitution'
require_relative 'index'
require_relative 'image'
require_relative 'unicode'

module Prawn
  module Emoji
    class Drawer
      def initialize(document:)
        @document = document
        @emoji_index = Emoji::Index.new
      end

      def draw(text, text_options)
        # Skip if text encoding is not UTF-8.
        return text unless text.encoding == ::Encoding::UTF_8

        draw_emoji(text, text_options)
      end

      private

      def draw_emoji(text, text_options)
        return text unless @emoji_index.to_regexp =~ text

        result_texts = []
        target_text = text

        while target_text do
          left_text, emoji_unicode, remaining_text = partition_emoji(target_text)

          if emoji_unicode.nil?
            result_texts << target_text
            break
          end

          current_result_texts = [left_text]
          current_result_texts <<
            if emoji_unicode.text?
              emoji_unicode.to_s
            else
              emoji_image = Emoji::Image.new(emoji_unicode)

              emoji_x, emoji_y = text_options[:at]
              emoji_x += @document.width_of(result_texts.join + left_text, text_options)
              emoji_y += @document.font_size

              draw_emoji_image emoji_image, at: [emoji_x, emoji_y], width: @document.font_size

              Emoji::Substitution.new(@document).to_s
            end

          result_texts += current_result_texts
          target_text = remaining_text
        end

        result_texts.join
      end

      def draw_emoji_image(emoji_image, at:, width:)
        @document.image emoji_image.path, at: at, width: width
      end

      def partition_emoji(text)
        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.to_regexp)

        return nil if emoji_unicode.empty?

        [
          left_text,
          Emoji::Unicode.new(emoji_unicode),
          remaining_text
        ]
      end
    end
  end
end
