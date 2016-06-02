module Prawn
  module Emoji
    class Index
      def unicodes
        EmojidexEmoji.unicodes
      end

      def unicodes_regexp
        @unicodes_regexp ||= build_unicodes_regexp
      end

      def surrogate_pair
        @surrogate_pair ||= build_surrogate_pair
      end

      private

      def build_unicodes_regexp
        low_unicodes = []
        array = unicodes.map do |unicode|
          if unicode.include?('-')
            multi_symbol = unicode.split('-')
            "\\u{#{multi_symbol[0]}}-\\u{#{multi_symbol[1]}}"
          else
            "\\u{#{unicode}}"
          end
        end
        Regexp.compile array.join('|')
      end

      def build_surrogate_pair
        @surrogate_pair = unicodes.select { |unicode| unicode.include?('-') }
      end
    end
  end
end
