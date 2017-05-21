module Prawn
  module Emoji
    class Index
      EXCLUSION_CHARS = '1234567890#*'.freeze

      def unicodes
        @unicodes ||= load_unicodes
      end

      def unicodes_regexp
        @unicodes_regexp ||= build_unicodes_regexp
      end

      private

      def build_unicodes_regexp
        Regexp.compile unicodes.map { |unicode| unicode_literal(unicode) }.join('|')
      end

      def load_unicodes
        unicodes = YAML.load(Emoji.root.join('emoji', 'index.yml').read)
        unicodes.reject { |unicode| /#{unicode_literal(unicode)}/ =~ EXCLUSION_CHARS }
      end

      def unicode_literal(unicode)
        "\\u{#{unicode.split('-').join(' ')}}"
      end
    end
  end
end
