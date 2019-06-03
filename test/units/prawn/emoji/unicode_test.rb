# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Unicode do
  def unicode(emoji)
    Prawn::Emoji::Unicode.new(emoji)
  end

  describe '#==' do
    it { unicode('🐟').must_be :==, unicode('🐟') }
    it { unicode('🐟').wont_be :==, unicode('🍣') }
  end

  describe '#codepoint' do
    it { unicode('🍣').codepoint.must_equal '1f363' }
    it { unicode('🇯🇵').codepoint.must_equal '1f1ef-1f1f5' }
  end

  describe '#to_s' do
    it { unicode('🍣').to_s.must_equal '🍣' }
    it { unicode('❤️').to_s.wont_match /[\ufe0e\ufe0f]/ }
  end

  describe 'delete variation selector' do
    describe 'no selector' do
      it { unicode("\u2600").codepoint.must_equal '2600' }
    end

    describe 'with text presentation selector' do
      it { unicode("\u2600\ufe0e").codepoint.must_equal '2600' }
    end

    describe 'with emoji presentation selector' do
      it { unicode("\u2600\ufe0f").codepoint.must_equal '2600' }
    end
  end
end
