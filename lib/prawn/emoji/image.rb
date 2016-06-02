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
        emoji = EmojidexEmoji::collection.find_by_unicode codepoint
        "#{EmojidexEmoji::source_path}/#{size}/#{emoji.code}.png"
      end

      def ==(other)
        unicode == other.unicode
      end

      private

      def codepoint
        @codepoint ||= build_codepoint
      end

      def build_codepoint
        @codepoint = @unicode.codepoints.map do |c|
          c.to_s(16).length == 2 ? "00#{c.to_s(16)}" : c.to_s(16)
        end.join('-')
      end
    end
  end
end
