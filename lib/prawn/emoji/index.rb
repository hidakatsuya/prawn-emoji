# frozen_string_literal: true

require 'yaml'

module Prawn
  module Emoji
    class Index
      attr_reader :codepoints

      def initialize
        @codepoints = load_emoji_codepoints
      end

      def include?(codepoint)
        codepoints.include?(codepoint)
      end

      private

      def load_emoji_codepoints
        YAML.load_file(Emoji.root.join('emoji', 'index.yml'))
      end
    end
  end
end
