# frozen_string_literal: true

require 'unicode/emoji'

require_relative 'unicode'

module Prawn
  module Emoji
    class Text
      attr_reader :left, :emoji, :remaining

      def initialize(text)
        @left, emoji_char, @remaining = partition_by_emoji(text)
        @emoji = Emoji::Unicode.new(emoji_char) unless emoji_char.empty?
      end

      def include_emoji?
        !emoji.nil?
      end

      def left_with_emoji
        left + emoji.to_s
      end

      def to_s
        left_with_emoji + remaining
      end

      private

      def partition_by_emoji(text)
        text.partition(Emoji::REGEX)
      end
    end
  end
end
