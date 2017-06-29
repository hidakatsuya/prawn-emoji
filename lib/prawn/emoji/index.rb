# frozen_string_literal: true

require_relative 'unicode'

module Prawn
  module Emoji
    class Index
      EXCLUSION_CHARS = '1234567890#*'.freeze

      attr_reader :codepoints

      def initialize
        @codepoints = load_emoji_codepoints
      end

      def to_regexp
        @regexp ||= build_regexp
      end

      private

      def build_regexp
        emojis = codepoints.map { |codepoint| unicode(codepoint) }
        variation_selectors = Emoji::Unicode::VARIATION_SELECTORS.values

        Regexp.new("(#{emojis.join('|')})[#{variation_selectors.join}]?")
      end

      def load_emoji_codepoints
        codepoints = YAML.load_file(Emoji.root.join('emoji', 'index.yml'))
        codepoints.reject { |codepoint| /#{unicode(codepoint)}/ =~ EXCLUSION_CHARS }
      end

      def unicode(codepoint)
        "\\u{#{codepoint.split('-').join(' ')}}"
      end
    end
  end
end
