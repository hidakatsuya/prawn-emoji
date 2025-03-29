# Changelog

> [!IMPORTANT]
> The Changelog has moved to GitHub Releases since 6.0.0. Please refer to: https://github.com/hidakatsuya/prawn-emoji/releases

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 5.3.0

### Added

* Support Emoji 14.0
* Update to Twemoji 14.0.1

## 5.2.0

### Changed

* Update unicode-emoji to v3.1.0 [@aried3r]
* And now prawn-emoji depends on unicode-emoji v3.x
  * Excluded PATCH level from version constraints for unicode-emoji

## 5.1.0

### Changed

* Update Twemoji to 13.1.1

## 5.0.0

### Changed

* Drop Prawn 2.2 support
* Drop Ruby 2.5 support

### Added

* Support Emoji 13.1 #43 [@aried3r]
* Depends on unicode-emoji v2.8.x #43 [@aried3r]

## 4.2.0

### Added

* Ruby 3.0.0 support
* Prawn 2.4.0 support
* Update to Twemoji v13.0.1
* Depends on unicode-emoji v2.7.x

## 4.1.0

### Added

* Add prawn 2.3.0 support #35

## 4.0.0

### Changed

* Drop ruby 2.4 support
* The drawing results of emoji will be changed slightly due to the new emoji drawing process

### Added

* prawn-emoji is no longer dependent on a particular font due to the new emoji drawing process

### Fixed

* Some emojis are not displayed #34

## 3.3.0

### Added

 * Support Emoji 13.0 #33 [@aried3r]

## 3.2.0

### Added

 * Ruby 2.7.0 support
 * Emoji Regex is now configurable using `Prawn::Emoji.config.regex` #30
   ```
   Prawn::Emoji.config.regex # => ::Unicode::Emoji::REGEX_VALID by default
   Prawn::Emoji.config.regex = ::Unicode::Emoji::REGEX_INCLUDE_TEXT
   ```

### Fixed

 * Fixed: Emoji Drawer does not close the file descriptor of emoji image #31

## 3.1.0

### Added

 * Support Emoji 12.1

### Changed

 * Update to Twemoji 12.1.3
   * This version includes some new emoji support and emoji CHANGES. See [commit](https://github.com/hidakatsuya/prawn-emoji/commit/96cb731d337721bf89be9463d270cc46962380d9) for details

## 3.0.0

### Changed

 * Switch emoji to [Twemoji](https://github.com/twitter/twemoji) v12.04 from EmojiOne v2.0
   * See [#23 Switch to Twemoji](https://github.com/hidakatsuya/prawn-emoji/issues/23) for further details
 * Support joined emojis like 👨‍👨‍👦 or 1️⃣
   * See [#24 Joined emojis like 👨‍👨‍👦 or 1️⃣ are not drawn](https://github.com/hidakatsuya/prawn-emoji/issues/24) for further details
 * Drop support ruby2.1 and 2.2, 2.3
 * prawn-emoji requires Prawn 2.2 (Drop support Prawn 2.1)

## 2.1.1

### Fixed

 * Fixed: A text including multiple emojis are broken #19

## 2.1.0

### Changed

 * Support variation selector
   * An emoji with text presentation selector such as ☀︎ (U+2600 U+FE0E) will be drawn as text
   * See also http://www.unicode.org/reports/tr51/tr51-12.html#def_text_presentation_selector

## 2.0.1

### Fixed

 * Fixed: part of ASCII chars and symbols is unexpectedly replaced with emojis #17 [@juanfal]

## 2.0.0

### Changed

 * prawn-emoji requires Prawn 2.1 or higher
   - NOTE: prawn-emoji 1.x supports Prawn 1.3 and 2.0

### Added

 * Support multi character emojis with updating to latest version Emojione's emojis #15

## 1.0.2

### Fixed

 * Fixed: © \u{00a9} is not rendered (commit: 32d55b0)

## 1.0.1

### Fixed

 * Skip drawing if the text encoding is not UTF-8 (commit: 033f05e)

## 1.0.0

First release.
