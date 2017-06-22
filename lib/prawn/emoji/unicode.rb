# frozen_string_literal: true

module Prawn
  module Emoji
    class Unicode
      VARIATION_SELECTORS = %w(\ufe0e \ufe0f).freeze

      def initialize(unicode)
        @unicode = delete_variation_selector(unicode)
      end

      def ==(other)
        to_s == other.to_s
      end

      def codepoint
        @codepoint ||= unicode.codepoints.map { |c| '%04x' % c.to_s }.join('-').downcase
      end

      def to_s
        unicode
      end

      private

      attr_reader :unicode

      def delete_variation_selector(unicode)
        unicode.gsub(/[#{VARIATION_SELECTORS.join}]/, '')
      end
    end
  end
end
