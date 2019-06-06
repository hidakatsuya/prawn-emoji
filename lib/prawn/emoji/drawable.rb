# frozen_string_literal: true

require_relative 'drawer'

module Prawn
  module Emoji
    module Drawable
      def draw_text!(text, options)
        text_without_emoji = emoji_drawer.draw(text.to_s, options)
        super text_without_emoji, options
      end

      private

      def emoji_drawer
        @emoji_drawer ||= Emoji::Drawer.new(self)
      end
    end
  end
end
