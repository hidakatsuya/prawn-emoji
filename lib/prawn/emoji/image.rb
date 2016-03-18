require 'yaml'

module Prawn
  module Emoji
    class Image
      STORE = Emoji.root.join 'emoji', 'images'

      attr_reader :unicode

      def initialize(unicode)
        @unicode = unicode
      end

      def path(size = 'px64')
        emoji = Prawn::EmojidexEmoji::collection.find_by_unicode codepoint
        "#{Prawn::EmojidexEmoji::cache_path}/#{size}/#{emoji.code}.png"
      end

      def ==(other)
        unicode == other.unicode
      end

      private

      def codepoint
        @codepoint ||= @unicode.codepoints.map { |c| c.to_s(16) }.join.upcase
      end
    end
  end
end
