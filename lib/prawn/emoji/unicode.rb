# frozen_string_literal: true

module Prawn
  module Emoji
    class Unicode
      VARIATION_SELECTORS = {
        text:  '\ufe0e',
        emoji: '\ufe0f'
      }.freeze

      def initialize(char)
        @present_as_text = !!char.match(VARIATION_SELECTORS[:text])
        @unicode = delete_variation_selector(char)
      end

      def ==(other)
        to_s == other.to_s
      end

      def codepoint
        @codepoint ||= @unicode.codepoints.map { |c| '%04x' % c.to_s }.join('-').downcase
      end

      def text?
        @present_as_text
      end

      def to_s
        @unicode
      end

      private

      def delete_variation_selector(char)
        char.gsub(/[#{VARIATION_SELECTORS.values.join}]/, '')
      end
    end
  end
end
