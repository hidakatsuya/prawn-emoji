# frozen_string_literal: true

module Prawn
  module Emoji
    class Image
      STORE = Emoji.root.join 'emoji', 'images'

      def initialize(emoji_char)
        @emoji_char = emoji_char
      end

      def path
        STORE.join("#{emoji_char.codepoint}.png").to_s
      end

      private

      attr_reader :emoji_char
    end
  end
end
