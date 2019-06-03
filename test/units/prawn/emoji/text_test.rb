# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Text do
  subject { Prawn::Emoji::Text.new(text) }

  describe 'partition by emoji' do
    let(:text) { 'leftleft🍣remaining'}

    it { subject.left.must_equal 'leftleft' }
    it { subject.remaining.must_equal 'remaining' }
    it { subject.emoji.must_be_instance_of Prawn::Emoji::Unicode }
    it { subject.emoji.to_s.must_equal '🍣' }

    describe 'no emoji' do
      let(:text) { 'abcd' }

      it { subject.left.must_equal 'abcd' }
      it { subject.emoji.must_be_nil }
      it { subject.remaining.must_equal '' }
    end

    describe 'emoji only' do
      let(:text) { '🎉' }

      it { subject.left.must_equal '' }
      it { subject.emoji.to_s.must_equal '🎉' }
      it { subject.remaining.must_equal '' }
    end

    describe 'empty' do
      let(:text) { '' }

      it { subject.left.must_equal '' }
      it { subject.emoji.must_be_nil }
      it { subject.remaining.must_equal '' }
    end
  end

  describe '#include_emoji?' do
    describe 'includes' do
      let(:text) { '👍' }
      it { subject.must_be :include_emoji? }
    end

    describe 'not includes' do
      let(:text) { 'text only' }
      it { subject.wont_be :include_emoji? }
    end
  end

  describe '#left_with_emoji' do
    let(:text) { 'aaaaaa📌bbbbbb' }
    it { subject.left_with_emoji.must_equal 'aaaaaa📌' }
  end

  describe '#to_s' do
    let(:text) { 'aaaaaa📌bbbbbb' }
    it { subject.to_s.must_equal text }
  end
end
