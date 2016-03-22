require 'prawn'
require 'prawn/emoji'
require 'prawn/emojidex'

Prawn::EmojidexEmoji::init_emojidex
Prawn::EmojidexEmoji::cache

Prawn::Document.generate 'foo.pdf' do
  font 'fonts/DejaVuSans.ttf'
  text '🍣'
  text 'Hello'
  text '🇯🇵'
  text '😀😀🏻😀🏼😀🏽😀🏾😀🏿'
  text '1234567890#1⃣2⃣3⃣4⃣5⃣6⃣7⃣8⃣9⃣0⃣#⃣'
end
