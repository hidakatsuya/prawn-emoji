# frozen_string_literal: true

require 'pdf/test_helper'

module PrawnIntegration
  class TestCase < PdfTest
    set_case_name :prawn_integration

    def test_pdf
      Pdf.generate(actual_pdf) do |pdf|
        pdf.raw { |prawn| prawn.font Pdf::UNICODE_FONT }

        pdf.section 'Prawn::Document#text' do
          pdf.raw { |prawn|
            prawn.text 'sushi🍣teacup🍵'
            prawn.font(Pdf::JAPANESE_FONT) {
              prawn.text '寿司🍣お茶🍵'
            }
          }
        end

        pdf.section 'Prawn::Document#draw_text' do
          pdf.raw { |prawn|
            prawn.move_down 10
            prawn.draw_text 'sushi🍣teacup🍵', at: [0, prawn.cursor]
            prawn.move_down 15
            prawn.font(Pdf::JAPANESE_FONT) {
              prawn.draw_text '寿司🍣お茶🍵', at: [0, prawn.cursor]
            }
          }
        end

        pdf.section 'Prawn::Document#text_box' do
          pdf.raw { |prawn|
            prawn.text_box 'sushi🍣teacup🍵', at: [0, prawn.cursor], width: 300
            prawn.move_down 15
            prawn.font(Pdf::JAPANESE_FONT) {
              prawn.text_box '寿司🍣お茶🍵', at: [0, prawn.cursor], width: 300
            }
            prawn.move_down 20
            prawn.text_box '🍣🍣sushi🍵🍵tea' * 5, at: [0, prawn.cursor], width: 200, height: 100
          }
        end

        pdf.doc.move_down 35

        pdf.section 'Font Size' do
          pdf.raw { |prawn|
            prawn.font_size(8)  { prawn.text "sushi🍣 (size: #{prawn.font_size})" }
            prawn.font_size(16) { prawn.text "🍵tea (size: #{prawn.font_size})" }
          }
        end

        pdf.section 'Character Spacing' do
          pdf.raw { |prawn|
            prawn.text '🍣sushi🍣🍵tea🍵', character_spacing: 5
          }
        end

        pdf.section 'Text Alignment' do
          pdf.raw { |prawn|
            prawn.text_box '🍵left👈alignment🍣', align: :left, at: [0, prawn.cursor], width: 300
            prawn.move_down 15
            prawn.text_box '🍵center↔alignment🍣', align: :center, at: [0, prawn.cursor], width: 300
            prawn.move_down 15
            prawn.text_box '🍵right👉alignment🍣', align: :right, at: [0, prawn.cursor], width: 300
          }
        end

        pdf.section 'Rotation' do
          pdf.raw { |prawn|
            prawn.text_box '🍣' * 10, rotate: 315, at: [10, prawn.cursor], width: 150, height: 20
          }
        end
      end

      assert_pdf
    end
  end
end
