require 'prawn'
require 'prawn/emoji'
require 'prawn/emojidex'

Prawn::EmojidexEmoji::init_emojidex
Prawn::EmojidexEmoji::cache

Prawn::Document.generate 'foo.pdf' do
  font 'fonts/ipag.ttf'
  text 'Hello'
  text '🍣🍕🍜🍔食べたい。'
  text '🇯🇯🇵🇵🇺🇸🇬🇧'
  text '😀😀🏻😀🏼😀🏽😀🏾😀🏿'
  text '1234567890#1⃣12⃣23⃣34⃣45⃣56⃣67⃣78⃣89⃣90⃣0#⃣#'
end
