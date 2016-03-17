require 'prawn'
# require 'prawn-svg'
require 'prawn/emoji'
require 'prawn/emojidex'

Prawn::EmojidexEmoji::init_emojidex
Prawn::EmojidexEmoji::cache

Prawn::Document.generate 'foo.pdf' do
  font 'fonts/DejaVuSans.ttf'
  text '🍣'
  text 'Hello'

  text '🇯🇵'
end
