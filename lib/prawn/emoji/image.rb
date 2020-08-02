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

        position = [x, y + height]

        if Prawn::VERSION >= '2.3.0'
          document.image(path, at: position, width: width)
        else
          # Prawn 2.2 does not close the image file when Pathname is passed to Document#image method.
          # https://github.com/prawnpdf/prawn/pull/1090
          File.open(path, 'rb') do |image_file|
            document.image(image_file, at: position, width: width)
          end
        end
      end

      def path
        STORE.join("#{emoji_char.codepoint}.png").to_s
      end

      private

      attr_reader :emoji_char
    end
  end
end
