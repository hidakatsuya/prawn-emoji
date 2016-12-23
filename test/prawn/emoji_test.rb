require 'test_helper'

describe 'Prawn integration' do
  describe 'Prawn::Document#text' do
    it 'properly render text' do
      pdf = Prawn::Document.new do |doc|
        doc.font font_path('DejaVuSans.ttf')
        doc.text 'sushi🍣teacup🍵'

        doc.move_down 20

        doc.font font_path('ipag.ttf')
        doc.text '寿司🍣お茶🍵'
      end

      assert_properly_render_text(pdf)
    end
  end

  describe 'Prawn::Document#text_box' do
    it 'properly render text' do
      pdf = Prawn::Document.new do |doc|
        doc.font font_path('DejaVuSans.ttf')
        doc.text_box 'sushi🍣teacup🍵', at: [100, 100], width: 500

        doc.font font_path('ipag.ttf')
        doc.text_box '寿司🍣お茶🍵', at: [100, 300], width: 500
      end

      assert_properly_render_text(pdf)
    end
  end

  describe 'Prawn::Document#draw_text' do
    it 'properly render text' do
      pdf = Prawn::Document.new do |doc|
        doc.font font_path('DejaVuSans.ttf')
        doc.draw_text 'sushi🍣teacup🍵', at: [100, 100]

        doc.font font_path('ipag.ttf')
        doc.draw_text '寿司🍣お茶🍵', at: [100, 300]
      end

      assert_properly_render_text(pdf)
    end
  end

  def assert_properly_render_text(pdf)
    pdf_strings = extract_strings(pdf.render)

    pdf_strings.must_include "sushi#{nbsp * 3}teacup#{nbsp * 3}"
    pdf_strings.must_include "寿司　お茶　"
  end

  def font_path(name)
    Prawn::Emoji.root.join 'test', 'fonts', name
  end

  def extract_strings(pdf)
    PDF::Inspector::Text.analyze(pdf).strings
  end

  def nbsp
    Prawn::Text::NBSP
  end
end
