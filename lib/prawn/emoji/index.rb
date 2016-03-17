module Prawn
  module Emoji
    class Index
      def unicodes
        Prawn::EmojidexEmoji.unicodes
      end

      def unicodes_regexp
        @unicodes_regexp ||= build_unicodes_regexp
      end

      private

      def build_unicodes_regexp
        str = unicodes.map do |unicode|
          if unicode.include?('-')
            unicode_array = unicode.split('-')
            "\\u{#{unicode_array[0]}}-\\u{#{unicode_array[1]}}"
          else
            "\\u{#{unicode}}"
          end
        end.join('|')
        Regexp.compile str
      end
    end
  end
end
