# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Char do
  def char(emoji)
    Prawn::Emoji::Char.new(emoji, font_size)
  end

  let(:font_size) { 12 }

  describe '.format_codepoint' do
    [
      [%w(abcd), 'abcd'],
      [%w(ABCD), 'abcd'],
      [%w(a), '000a'],
      [%w(1234 5678 9012), '1234-5678-9012'],
      [%w(A B C), '000a-000b-000c']
    ].each do |(args, expect)|
      it { _(Prawn::Emoji::Char.format_codepoint(args)).must_equal expect }
    end
  end

  describe '#==' do
    it { _(char('🐟')).must_be :==, char('🐟') }
    it { _(char('🐟')).wont_be :==, char('🍣') }
  end

  describe '#codepoint' do
    it { _(char('🍣').codepoint).must_equal '1f363' }
    it { _(char('🇯🇵').codepoint).must_equal '1f1ef-1f1f5' }
  end

  describe '#to_s' do
    it { _(char('🍣').to_s).must_equal '🍣' }
    it { _(char('❤️').to_s).must_equal "\u2764\ufe0f" }
  end

  describe 'delete variation selector' do
    describe 'no selector' do
      it { _(char("\u2600").codepoint).must_equal '2600' }
    end

    describe 'with text presentation selector' do
      it { _(char("\u2600\ufe0e").codepoint).must_equal '2600' }
    end

    describe 'with emoji presentation selector' do
      it { _(char("\u2600\ufe0f").codepoint).must_equal '2600' }
    end
  end

  describe '#width' do
    it { _(char('🍣').width).must_equal font_size * 0.85 }
  end

  describe '#height' do
    it { _(char('🍣').height).must_equal font_size * 0.8 }
  end
end
