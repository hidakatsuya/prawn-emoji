## master

Breaking Changes:

 * Drop support ruby2.1 and 2.2, 2.3

## 2.1.1

### Bug Fixes:

 * Fixed: A text including multiple emojis are broken #19

## 2.1.0

### Breaking Changes

 * Support variation selector
   * An emoji with text presentation selector such as ☀︎ (U+2600 U+FE0E) will be drawn as text
   * See also http://www.unicode.org/reports/tr51/tr51-12.html#def_text_presentation_selector

## 2.0.1

### Bug Fixes:

 * Fixed: part of ASCII chars and symbols is unexpectedly replaced with emojis #17 [@juanfal]

## 2.0.0

 * prawn-emoji requires Prawn 2.1 or higher
   - NOTE: prawn-emoji 1.x supports Prawn 1.3 and 2.0
 * Support multi character emojis with updating to latest version Emojione's emojis #15

## 1.0.2

 * Fixed: © \u{00a9} is not rendered (commit: 32d55b0)
 * Development: Add task for generating emoji index from emoji images (commit: 2d41247)

## 1.0.1

 * Skip drawing if the text encoding is not UTF-8 (commit: 033f05e)

## 1.0.0

First release.
