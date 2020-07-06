# frozen_string_literal: true

require_relative 'drawer'

module Prawn
  module Emoji
    module Drawable
      # == Additional Options
      # <tt>:emoji</tt>:: <tt>boolean</tt>. Whether or not to draw an emoji [true]
      def draw_text!(text, options)
        draw_emoji = options.fetch(:emoji, true)

        if draw_emoji && text.encoding == ::Encoding::UTF_8 && Emoji.regex.match?(text)
          emoji_drawer.draw(text.to_s, options)
        else
          super(text, options)
        end
      end

      private

      def emoji_drawer
        @emoji_drawer ||= Emoji::Drawer.new(self)
      end
    end
  end
end
