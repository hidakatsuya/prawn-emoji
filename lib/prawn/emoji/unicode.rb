# frozen_string_literal: true

module Prawn
  module Emoji
    class Unicode
      VARIATION_SELECTORS = %w(fe0e fe0f).freeze

      class << self
        def format_codepoint(codepoints)
          (codepoints - VARIATION_SELECTORS).map { |c| c.rjust(4, '0') }.join('-').downcase
        end
      end

      def initialize(char)
        @unicode = char
      end

      def ==(other)
        to_s == other.to_s
      end

      def codepoint
        @codepoint ||= self.class.format_codepoint(@unicode.codepoints.map { |c| c.to_s(16) })
      end

      def to_s
        @unicode
      end
    end
  end
end
