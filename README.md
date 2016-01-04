# Prawn::Emoji

[![Build Status](https://travis-ci.org/hidakatsuya/prawn-emoji.svg)](https://travis-ci.org/hidakatsuya/prawn-emoji)

Prawn::Emoji is an extention for [Prawn](https://github.com/prawnpdf/prawn), provides feature for drawing Emoji.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prawn-emoji', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prawn-emoji

## Usage

```ruby
require 'prawn'
require 'prawn/emoji'

Prawn::Docment.generate 'foo.pdf' do
  font 'DejaVuSans.ttf'
  text 'I want to eat 🍣.'

  font 'ipag.ttf'
  text_box '🍣が食べたい', at: [100, 100], width: 300

  draw_text '🍣🍣🍣🍣🍣', at: [100, 200]
end
```

### CAUTION

In order to draw emoji, you will need to use a TTF - True Type Font. I strongly recommended you use a Japanese font.

## Feature

  * [Over 1600 emoji](http://emojione.com) support provided by Emoji One
  * RTL support
  * Character specing support
  * Rotation support
  * Alignment support
  * Font size support

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hidakatsuya/prawn-emoji.

## Credit

### Emoji One

Emoji provided free by [Emoji One](http://emojione.com/).

### IPA Font

[IPA Font License Agreement v1.0](http://ipafont.ipa.go.jp/ipa_font_license_v1.html)

## License

© 2015 Katsuya HIDAKA. See MIT-LICENSE for further details.
