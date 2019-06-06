# frozen_string_literal: true

require 'yaml'
require_relative 'unicode'

module Prawn
  module Emoji
    class Image
      STORE = Emoji.root.join 'emoji', 'images'

      attr_reader :unicode, :font_size

      def initialize(unicode, font_size)
        @unicode = unicode
        @font_size = font_size
      end

      def path
        STORE.join("#{unicode.codepoint}.png").to_s
      end

      def adjust_x(base_x)
        base_x + (font_size - width) / 2
      end

      def adjust_y(base_y)
        base_y + font_size * 0.8
      end

      def width
        font_size * 0.85
      end

      def ==(other)
        unicode == other.unicode
      end
    end
  end
end
