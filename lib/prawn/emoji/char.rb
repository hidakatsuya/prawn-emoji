# frozen_string_literal: true

module Prawn
  module Emoji
    class Char
      VARIATION_SELECTORS = %w(fe0e fe0f).freeze

      class << self
        def format_codepoint(codepoints)
          (codepoints - VARIATION_SELECTORS).map { |c| c.rjust(4, '0') }.join('-').downcase
        end
      end

      attr_reader :font_size, :char
      alias_method :to_s, :char

      def initialize(char, font_size)
        @char = char
        @font_size = font_size
      end

      def ==(other)
        char == other.to_s
      end

      def codepoint
        @codepoint ||= self.class.format_codepoint(char.codepoints.map { |c| c.to_s(16) })
      end

      def width
        @width ||= font_size * 0.85
      end

      def height
        @height ||= font_size * 0.8
      end
    end
  end
end
