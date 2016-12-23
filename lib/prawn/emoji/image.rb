require 'yaml'

module Prawn
  module Emoji
    class Image
      STORE = Emoji.root.join 'emoji', 'images'

      attr_reader :unicode

      def initialize(unicode)
        @unicode = unicode
      end

      def path
        STORE.join("#{codepoint}.png").to_s
      end

      def ==(other)
        unicode == other.unicode
      end

      private

      def codepoint
        @codepoint ||= @unicode.codepoints.map { |c| '%04x' % c.to_s }.join('-').downcase
      end
    end
  end
end
