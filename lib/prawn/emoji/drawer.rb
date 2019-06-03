# frozen_string_literal: true

require_relative 'substitution'
require_relative 'index'
require_relative 'image'
require_relative 'text'

module Prawn
  module Emoji
    class Drawer
      def initialize(document:)
        @document = document
        @emoji_index = Emoji::Index.new
      end

      def draw(text, text_options)
        return text unless text.encoding == ::Encoding::UTF_8
        return text unless Emoji::REGEX.match?(text)

        result = []
        target = Emoji::Text.new(text)

        while target.include_emoji? do
          if emoji_index.include?(target.emoji.codepoint)
            draw_emoji(
              target,
              text_options: text_options,
              result_texts: result.join
            )
            result << target.left + Emoji::Substitution.new(@document).to_s
          else
            result << target.left_with_emoji
          end

          target = Emoji::Text.new(target.remaining)
        end

        result.join + target.to_s
      end

      private

      attr_reader :emoji_index

      def draw_emoji(text, text_options:, result_texts:)
        emoji_image = Emoji::Image.new(text.emoji)

        emoji_x, emoji_y = text_options[:at]
        emoji_x += @document.width_of(result_texts + text.left, text_options)
        emoji_y += @document.font_size

        @document.image emoji_image.path, at: [emoji_x, emoji_y], width: @document.font_size
      end
    end
  end
end
