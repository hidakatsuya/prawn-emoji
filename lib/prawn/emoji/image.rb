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
        return @codepoint unless @codepoint.nil?

        if @unicode.length > 2
          @codepoint = "#{@unicode[0..-2]}-#{@unicode[-1].codepoints[0].to_s(16)}"
        else
          @codepoint = @unicode.codepoints.map { |c| c.to_s(16) }.join('-')
        end
      end
    end
  end
end
