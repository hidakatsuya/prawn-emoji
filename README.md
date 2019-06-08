# Prawn::Emoji

[![Gem Version](https://badge.fury.io/rb/prawn-emoji.svg)](https://badge.fury.io/rb/prawn-emoji)
[![Build Status](https://travis-ci.org/hidakatsuya/prawn-emoji.svg)](https://travis-ci.org/hidakatsuya/prawn-emoji)
[![Maintainability](https://api.codeclimate.com/v1/badges/edcd23ef38c2e393513b/maintainability)](https://codeclimate.com/github/hidakatsuya/prawn-emoji/maintainability)

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

In order to run the following code, you need to place [DejaVuSans.ttf](http://sourceforge.net/projects/dejavu/) in the same directory as the script file.

```ruby
require 'prawn/emoji'

Prawn::Document.generate 'sushi.pdf' do
  font 'DejaVuSans.ttf'
  text '🐟 / 🔪 + 🍚 / 🍾 = 🍣'
end
```

### IMPORTANT

In order to draw emoji, you must use a TTF - True Type Font. I recommend you use a Japanese font.

## Feature

  * Emoji is provided by [Twemoji](https://github.com/twitter/twemoji)
  * Multi-character emoji support
  * RTL support
  * Character spacing support
  * Rotation support
  * Alignment support
  * Font size support

### Known Issues

See [prawn-emoji/issues](https://github.com/hidakatsuya/prawn-emoji/labels/known%20issue)

## Support Status

### Emoji

See [test/pdf/emoji_rendering/expect.pdf](https://github.com/hidakatsuya/prawn-emoji/blob/master/test/pdf/emoji_rendering/expect.pdf)

### Ruby

2.4, 2.5, 2.6

See also https://travis-ci.org/hidakatsuya/prawn-emoji

### Prawn

2.2+

See also [test/pdf/prawn_integration/expect.pdf](https://github.com/hidakatsuya/prawn-emoji/blob/master/test/pdf/prawn_integration/expect.pdf)

### NOTICE

  * prawn-emoji 2.x supports Prawn 2.1
  * prawn-emoji 1.x supports Prawn 1.3 and 2.0. See [README in 1.0-stable branch](https://github.com/hidakatsuya/prawn-emoji/blob/1.0-stable/README.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hidakatsuya/prawn-emoji.

### How to test

Run all tests:

```
$ bundle exec rake test
```

Run unit tests:

```
$ bundle exec rake test:units
```

Run pdf tests:

```
$ bundle exec rake test:pdf
```

**NOTICE:** In order to run `test:pdf`, you need to install [diff-pdf](https://github.com/vslavik/diff-pdf) in your environment.

### How to update `emoji/index.yml`

```
$ bundle exec rake emoji:update
```

This task works the following:

1. Download emoji images from https://github.com/twitter/twemoji/
2. Save the emoji images in the `emoji/images/`
3. Write image list in `emoji/images/` to `emoji/index.yml`

## Credit

### Twemoji 12.04

[Twemoji](https://github.com/twitter/twemoji) Graphics licensed under [CC-BY4.0](https://creativecommons.org/licenses/by/4.0/)

### IPA Font

[IPA Font License Agreement v1.0](http://ipafont.ipa.go.jp/ipa_font_license_v1.html)

## License

© 2015 Katsuya HIDAKA. See MIT-LICENSE for further details.
