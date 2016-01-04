require_relative 'drawer'

module Prawn
  module Emoji
    module Drawable
      def draw_text!(text, options)
        text_without_emoji = emoji_drawer.draw(text, options)
        super text_without_emoji, options
      end

      private

      def emoji_drawer
        @emoji_drawer ||= Emoji::Drawer.new document: self
      end
    end
  end
end
