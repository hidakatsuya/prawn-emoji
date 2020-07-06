# frozen_string_literal: true

$:.unshift File.expand_path('../../lib', __FILE__)

require 'prawn'
require 'prawn/emoji'

require 'minitest/autorun'
require 'pathname'

class PdfTest < Minitest::Test
  class << self
    attr_reader :case_name

    def set_case_name(name)
      @case_name = name.to_s
    end
  end

  def assert_match_pdf
    if expect_pdf.exist?
      assert match_pdf?, 'actual.pdf does not match expect.pdf. Check diff.pdf for details.'
    else
      flunk 'expect.pdf does not exist.'
    end
  end

  def actual_pdf
    @actual_pdf ||= dir.join('actual.pdf')
  end

  def expect_pdf
    @expect_pdf ||= dir.join('expect.pdf')
  end

  def diff_pdf
    dir.join('diff.pdf')
  end

  def dir
    @dir ||= Pathname.new(__dir__).join(self.class.case_name)
  end

  def match_pdf?
    system("diff-pdf --mark-differences --output-diff=#{diff_pdf} #{expect_pdf} #{actual_pdf}")
  end

  class Pdf
    UNICODE_FONT = Prawn::Emoji.root.join('test/fonts/DejaVuSans.ttf')
    JAPANESE_FONT = Prawn::Emoji.root.join('test/fonts/ipag.ttf')

    attr_reader :doc

    class << self
      def generate(filename)
        new.tap { |pdf| yield(pdf) }.render(filename)
      end
    end

    def initialize
      @doc = Prawn::Document.new(margin: 50)
    end

    def section(title)
      doc.font('Helvetica') { doc.text title, color: 'aaaaaa' }
      doc.move_down 5
      yield
      doc.move_down 10
    end

    def emoji(emoji, desc: nil)
      unicode = emoji.codepoints.map { |c| "U+#{c.to_s(16).upcase}" }.join(' ')
      text [emoji, "(#{unicode})", desc].compact.join(' ')
    end

    def emojis(emojis)
      emojis.each { |em| emoji(em) }
    end

    def text(string)
      doc.font(UNICODE_FONT) { doc.text(string, size: 10) }
    end

    def raw
      yield(doc)
    end

    def render(filename)
      doc.render_file(filename.to_s)
    end
  end
end
