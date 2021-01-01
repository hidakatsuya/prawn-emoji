# frozen_string_literal: true

require 'units/test_helper'

class Prawn::Emoji::DrawableTest < Test::Unit::TestCase
  class DocumentTest
    def draw_text!(text, options); end
  end

  setup { @document_test = DocumentTest.new.extend Prawn::Emoji::Drawable }

  test 'Emoji::Drawer should be called' do
    mock(@document_test.send(:emoji_drawer)).draw('text🍣', {}).times(2)

    @document_test.draw_text!('text🍣', {})
    @document_test.draw_text!('text🍣', emoji: true)
  end

  test 'Emoji::Drawer should not be called' do
    mock(@document_test.send(:emoji_drawer)).draw.with_any_args.never

    @document_test.draw_text!('text🍣', emoji: false)
    @document_test.draw_text!('text', emoji: true)
    @document_test.draw_text!('', emoji: true)
  end
end
