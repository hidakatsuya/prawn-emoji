# frozen_string_literal: true

require_relative 'index'
require_relative 'image'
require_relative 'text'

module Prawn
  module Emoji
    class Drawer
      def self.drawable?(text)
        text.encoding == ::Encoding::UTF_8 && Emoji.regex.match?(text)
      end

      def initialize(document)
        @document = document
        @emoji_index = Emoji::Index.new
      end

      def draw(text, text_options)
        cursor_x, cursor_y = text_options[:at]

        emoji_text = Emoji::Text.new(text, document.font_size)

        while emoji_text.contains_emoji? do
          if emoji_index.include?(emoji_text.emoji_char.codepoint)
            cursor_x += draw_text(emoji_text.left, at: [cursor_x, cursor_y], text_options: text_options)
            cursor_x += draw_emoji(emoji_text.emoji_char, at: [cursor_x, cursor_y])
          else
            cursor_x += draw_text(emoji_text.left_with_emoji, at: [cursor_x, cursor_y], text_options: text_options)
          end
          emoji_text = Emoji::Text.new(emoji_text.remaining, document.font_size)
        end

        draw_text!(emoji_text.to_s, at: [cursor_x, cursor_y], text_options: text_options)
      end

      private

      attr_reader :emoji_index, :document

      def draw_text!(text, at:, text_options:)
        document.draw_text!(text, text_options.merge(emoji: false, at: at))
      end

      def draw_text(text, at:, text_options:)
        draw_text!(text, at: at, text_options: text_options)
        document.width_of(text, text_options)
      end

      def draw_emoji(emoji_char, at:)
        emoji_image = Emoji::Image.new(emoji_char)

        x, y = at

        # Prawn 2.2 does not close the image file when Pathname is passed to Document#image method.
        #
        # FIXME: This issue has been fixed by https://github.com/prawnpdf/prawn/pull/1090 but not released.
        # Fix as follows after the PR released.
        #
        #   @document.image(image_file.path, at: [x, y], width: image.width)
        #
        File.open(emoji_image.path, 'rb') do |image_file|
          @document.image(image_file, at: [x, y + emoji_char.height], width: emoji_char.width)
        end

        emoji_char.width + document.character_spacing
      end
    end
  end
end
