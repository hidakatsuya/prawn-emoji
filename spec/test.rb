require 'prawn'
require 'prawn/emoji'

Prawn::Document.generate 'foo.pdf' do
  font File.expand_path('../fonts/ipag.ttf', __FILE__)
  text 'Hello'
  text '🍣🍕🍜🍔食べたい。'
  text '🇯🇯🇵🇵🇺🇸🇬🇧'
  text '😀😀🏻😀🏼😀🏽😀🏾😀🏿'
  text '1234567890#1⃣12⃣23⃣34⃣45⃣56⃣67⃣78⃣89⃣90⃣0#⃣#'
  text '❤️0️⃣❤️'
end
