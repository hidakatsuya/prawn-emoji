# frozen_string_literal: true

require 'forwardable'

module Prawn
  module Emoji
    class Substitution
      extend Forwardable

      FULL_SIZE_SPACE = '　'
      HALF_SIZE_SPACE = Prawn::Text::NBSP

      def_delegator :@document, :width_of

      def initialize(document)
        @document = document
        @font = document.font
        @font_size = document.font_size
      end

      def to_s
        emoji_width == full_size_space_width ? FULL_SIZE_SPACE : half_size_spaces
      end

      private

      def emoji_width
        @emoji_width ||= @font_size + @document.character_spacing
      end

      def full_size_space_width
        width_of @font.normalize_encoding(FULL_SIZE_SPACE)
      end

      def half_size_spaces
        HALF_SIZE_SPACE * (emoji_width.to_f / width_of(HALF_SIZE_SPACE)).round
      end
    end
  end
end
