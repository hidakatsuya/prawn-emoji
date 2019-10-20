# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Unicode do
  def unicode(emoji)
    Prawn::Emoji::Unicode.new(emoji)
  end

  describe '.format_codepoint' do
    [
      [%w(abcd), 'abcd'],
      [%w(ABCD), 'abcd'],
      [%w(a), '000a'],
      [%w(1234 5678 9012), '1234-5678-9012'],
      [%w(A B C), '000a-000b-000c']
    ].each do |(args, expect)|
      it { _(Prawn::Emoji::Unicode.format_codepoint(args)).must_equal expect }
    end
  end

  describe '#==' do
    it { _(unicode('🐟')).must_be :==, unicode('🐟') }
    it { _(unicode('🐟')).wont_be :==, unicode('🍣') }
  end

  describe '#codepoint' do
    it { _(unicode('🍣').codepoint).must_equal '1f363' }
    it { _(unicode('🇯🇵').codepoint).must_equal '1f1ef-1f1f5' }
  end

  describe '#to_s' do
    it { _(unicode('🍣').to_s).must_equal '🍣' }
    it { _(unicode('❤️').to_s).must_equal "\u2764\ufe0f" }
  end

  describe 'delete variation selector' do
    describe 'no selector' do
      it { _(unicode("\u2600").codepoint).must_equal '2600' }
    end

    describe 'with text presentation selector' do
      it { _(unicode("\u2600\ufe0e").codepoint).must_equal '2600' }
    end

    describe 'with emoji presentation selector' do
      it { _(unicode("\u2600\ufe0f").codepoint).must_equal '2600' }
    end
  end
end
