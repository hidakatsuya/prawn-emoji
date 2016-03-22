module Prawn
  module Emoji
    class Index
      def unicodes
        Prawn::EmojidexEmoji.unicodes
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
            unicode_array = unicode.split('-')
            low_unicodes << "\\u{#{unicode_array[1]}}"
            "\\u{#{unicode_array[0]}}-\\u{#{unicode_array[1]}}"
          else
            "\\u{#{unicode}}"
          end
        end
        array = array.concat(low_unicodes).uniq
        Regexp.compile array.join('|')
      end

      def build_surrogate_pair
        @surrogate_pair = []
        unicodes.each do |unicode|
          @surrogate_pair << unicode if unicode.include?('-')
        end
        @surrogate_pair
      end
    end
  end
end
