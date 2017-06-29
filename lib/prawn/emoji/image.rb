# frozen_string_literal: true

require 'yaml'
require_relative 'unicode'

module Prawn
  module Emoji
    class Image
      STORE = Emoji.root.join 'emoji', 'images'

      attr_reader :unicode

      def initialize(unicode)
        @unicode = unicode
      end

      def path
        STORE.join("#{unicode.codepoint}.png").to_s
      end

      def ==(other)
        unicode == other.unicode
      end
    end
  end
end
