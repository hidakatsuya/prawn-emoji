# frozen_string_literal: true

require_relative 'char'

module Prawn
  module Emoji
    class Text
      attr_reader :left, :emoji, :remaining

      def initialize(text, font_size)
        @text = text
        @left, emoji_char, @remaining = partition_by_emoji(text)
        @emoji = Emoji::Char.new(emoji_char, font_size) unless emoji_char.empty?
      end

      def contains_emoji?
        !emoji.nil?
      end

      def left_with_emoji
        left + emoji.to_s
      end

      def to_s
        @text
      end

      private

      def partition_by_emoji(text)
        text.partition(Emoji.regex)
      end
    end
  end
end
