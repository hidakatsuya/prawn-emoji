# Prawn::Emoji

[![Gem Version](https://badge.fury.io/rb/prawn-emoji.svg)](https://badge.fury.io/rb/prawn-emoji)
[![Build Status](https://travis-ci.org/hidakatsuya/prawn-emoji.svg)](https://travis-ci.org/hidakatsuya/prawn-emoji)

Prawn::Emoji is an extention for [Prawn](https://github.com/prawnpdf/prawn), provides feature for drawing Emoji.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prawn-emoji', require: false
# To bundle emoji assets locally uncomment the following line:
# gem 'emojidex-rasters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prawn-emoji

## Usage

In order to run the following code, you need to place both [DejaVuSans.ttf](http://sourceforge.net/projects/dejavu/) and [ipag.ttf](http://ipafont.ipa.go.jp/old/ipafont/download.html) in the same directory as the script file.

```ruby
require 'prawn'
require 'prawn/emoji'

Prawn::Document.generate 'foo.pdf' do
  font 'DejaVuSans.ttf'
  text '🐟 + 🔪 = 🍣'

  font 'ipag.ttf'
  text_box '🍣が食べたい', at: [100, 100], width: 300

  draw_text '🍣🍣🍣🍣🍣', at: [100, 200]
end
```


### IMPORTANT

In order to draw emoji, you must use a TTF - True Type Font. I recommend you use a Japanese font.

## Feature

  * [Over 2300 emoji](https://www.emojidex.com/users/emoji) support provided by emojidex
  * Includes modifier variant and Unicode candidate emoji
  * RTL support
  * Character specing support
  * Rotation support
  * Alignment support
  * Font size support

## Supported versions

See also https://travis-ci.org/hidakatsuya/prawn-emoji.

### Ruby

2.1, 2.2, 2.3

### Prawn

2.1

INFO: Version 1.x supports Prawn 1.3 and 2.0. See [README in 1.0-stable branch](https://github.com/hidakatsuya/prawn-emoji/blob/1.0-stable/README.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hidakatsuya/prawn-emoji.

## Credit

### emojidex

emoji provided free by [emojidex](https://www.emojidex.com/) under the emojidex Open License.

### IPA Font

[IPA Font License Agreement v1.0](http://ipafont.ipa.go.jp/ipa_font_license_v1.html)

## License

© 2015 Katsuya HIDAKA. See MIT-LICENSE for further details.
