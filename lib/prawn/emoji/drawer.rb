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
        if text.include?(65039.chr('UTF-8'))
          text = remove_variation_sequence(text)
        end

        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.unicodes_regexp)

        return text if emoji_unicode.empty?

        if check_next_emoji_unicode(remaining_text)
          next_emoji_unicode = get_next_emoji_unicode(remaining_text)
          if check_surrogate_pair(emoji_unicode, next_emoji_unicode)
            emoji_unicode = "#{emoji_unicode}#{next_emoji_unicode}"
            remaining_text = get_next_remaining_text(remaining_text)
          end
        end

        if !left_text.empty? && check_digit_emoji(left_text, emoji_unicode)
          emoji_unicode = "#{left_text[-1]}#{emoji_unicode}"
          left_text = left_text[0..-2]
        end

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

      def emoji_to_string(unicode)
        unicode.codepoints.map { |c| c.to_s(16) } [0]
      end

      def check_next_emoji_unicode(text)
        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.unicodes_regexp)
        !emoji_unicode.empty? && left_text.length == 0
      end

      def get_next_emoji_unicode(text)
        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.unicodes_regexp)
        emoji_unicode
      end

      def get_next_remaining_text(text)
        left_text, emoji_unicode, remaining_text = text.partition(@emoji_index.unicodes_regexp)
        remaining_text
      end

      def check_surrogate_pair(high, low)
        @emoji_index.surrogate_pair.include?("#{emoji_to_string(high)}-#{emoji_to_string(low)}")
      end

      def check_digit_emoji(high, low)
        '0123456789#'.include?(high[-1]) && emoji_to_string(low) == '20e3'
      end

      def remove_variation_sequence(text)
        new_text = ''
        text.each_codepoint { |c| new_text << c.chr('UTF-8') if c != 65039 }

        new_text
      end
    end
  end
end
