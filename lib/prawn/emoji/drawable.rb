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

      # Overrides Prawn's +width_of+ to correctly account for emoji image widths.
      #
      # Prawn's built-in +width_of+ uses font glyph metrics, which return 0 (or
      # garbage) for emoji codepoints that don't exist in any PDF font. This
      # causes text placed after an emoji to overlap the emoji image, because
      # Prawn thinks the emoji occupied zero horizontal space.
      #
      # This method mirrors the cursor-advance logic in Drawer#draw exactly:
      # - Plain-text segments → measured via +font_metric_cache.width_of+
      # - Emoji with an image  → measured via +Emoji::Char#width+ (font_size * 0.85),
      #   the same value used when the PNG is rendered
      # - Emoji without image  → measured via font metrics (same as Drawer fallback)
      # - +character_spacing+  → inserted once *between* non-empty segments,
      #   matching Prawn's behaviour after prawn/pull/1117
      def width_of(string, options = {})
        return super if options[:inline_format]

        s = string.to_s
        return super(s, options) if s.encoding != ::Encoding::UTF_8 || !Emoji::Drawer.drawable?(s)

        fs      = options[:size] || font_size
        # Cache all per-call lookups outside the loop.
        # emoji_index: send() paid once, not once-per-emoji
        # font_metric_cache / character_spacing: avoids repeated method dispatch
        drawer  = emoji_drawer
        idx     = drawer.send(:emoji_index)
        fmc     = font_metric_cache
        spacing = character_spacing

        total     = 0.0
        needs_sep = false

        chunk = Emoji::Text.new(s, fs)

        while chunk.contains_emoji?
          if idx.include?(chunk.emoji_char.codepoint)
            unless chunk.left.empty?
              w = fmc.width_of(chunk.left, options)
              unless w.zero?
                total += spacing if needs_sep
                total += w
                needs_sep = true
              end
            end

            # emoji_char.width == font_size * 0.85, same value Drawer#draw_emoji uses
            w = chunk.emoji_char.width
            unless w.zero?
              total += spacing if needs_sep
              total += w
              needs_sep = true
            end
          else
            w = fmc.width_of(chunk.left_with_emoji, options)
            unless w.zero?
              total += spacing if needs_sep
              total += w
              needs_sep = true
            end
          end

          chunk = Emoji::Text.new(chunk.remaining, fs)
        end

        tail = chunk.to_s
        unless tail.empty?
          w = fmc.width_of(tail, options)
          unless w.zero?
            total += spacing if needs_sep
            total += w
          end
        end

        total
      end

      private

      def emoji_drawer
        @emoji_drawer ||= Emoji::Drawer.new(self)
      end
    end
  end
end
