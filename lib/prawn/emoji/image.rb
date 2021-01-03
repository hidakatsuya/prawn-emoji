# frozen_string_literal: true

require 'forwardable'

module Prawn
  module Emoji
    class Image
      extend Forwardable

      STORE = Emoji.root.join 'emoji', 'images'

      def_delegators :emoji_char, :width, :height

      def initialize(emoji_char)
        @emoji_char = emoji_char
      end

      def render(document, at:)
        x, y = at
        document.image(path, at: [x, y + height], width: width)
      end

      def path
        STORE.join("#{emoji_char.codepoint}.png").to_s
      end

      private

      attr_reader :emoji_char
    end
  end
end
