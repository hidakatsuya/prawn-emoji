require_relative 'substitution'
require_relative 'index'
require_relative 'image'

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
        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.to_regexp)

        return text if emoji_unicode.empty?

        emoji_image = Emoji::Image.new(emoji_unicode)

        emoji_x, emoji_y = text_options[:at]
        emoji_x += @document.width_of(left_text, text_options)
        emoji_y += @document.font_size

        draw_emoji_image emoji_image, at: [emoji_x, emoji_y], width: @document.font_size

        substitution_of_emoji = Substitution.new(@document)
        draw_emoji "#{left_text}#{substitution_of_emoji}#{remaining_text}", text_options
      end

      def draw_emoji_image(emoji_image, at:, width:)
        @document.image emoji_image.path, at: at, width: width
      end
    end
  end
end
