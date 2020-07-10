# frozen_string_literal: true

require_relative 'char'

module Prawn
  module Emoji
    class Text
      attr_reader :left, :emoji_char, :remaining

      def initialize(text, font_size)
        @text = text
        @left, emoji, @remaining = partition_by_emoji(text)
        @emoji_char = Emoji::Char.new(emoji, font_size) unless emoji.empty?
      end

      def contains_emoji?
        !emoji_char.nil?
      end

      def left_with_emoji
        left + emoji_char.to_s
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
