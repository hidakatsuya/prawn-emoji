module Prawn
  module Emoji
    class Index
      def unicodes
        @unicodes ||= YAML.load Emoji.root.join('emoji', 'index.yml').read
      end

      def unicodes_regexp
        @unicodes_regexp ||= build_unicodes_regexp
      end

      private

      def build_unicodes_regexp
        Regexp.compile unicodes.map { |unicode| "\\u{#{unicode}}" }.join('|')
      end
    end
  end
end
