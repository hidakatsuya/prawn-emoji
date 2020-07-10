# frozen_string_literal: true

require_relative 'drawer'

module Prawn
  module Emoji
    module Drawable
      # == Additional Options
      # <tt>:emoji</tt>:: <tt>boolean</tt>. Whether or not to draw an emoji [true]
      def draw_text!(text, options)
        draw_emoji = options.delete(:emoji) { true }

        if draw_emoji && Emoji::Drawer.drawable?(text)
          emoji_drawer.draw(text.to_s, options)
        else
          super
        end
      end

      private

      def emoji_drawer
        @emoji_drawer ||= Emoji::Drawer.new(self)
      end
    end
  end
end
