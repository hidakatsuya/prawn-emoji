# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Text do
  subject { Prawn::Emoji::Text.new(text, 12) }

  describe 'partition by emoji' do
    let(:text) { 'leftleft🍣remaining'}

    it { _(subject.left).must_equal 'leftleft' }
    it { _(subject.remaining).must_equal 'remaining' }
    it { _(subject.emoji).must_be_instance_of Prawn::Emoji::Char }
    it { _(subject.emoji.to_s).must_equal '🍣' }

    describe 'no emoji' do
      let(:text) { 'abcd' }

      it { _(subject.left).must_equal 'abcd' }
      it { _(subject.emoji).must_be_nil }
      it { _(subject.remaining).must_equal '' }
    end

    describe 'emoji only' do
      let(:text) { '🎉' }

      it { _(subject.left).must_equal '' }
      it { _(subject.emoji.to_s).must_equal '🎉' }
      it { _(subject.remaining).must_equal '' }
    end

    describe 'empty' do
      let(:text) { '' }

      it { _(subject.left).must_equal '' }
      it { _(subject.emoji).must_be_nil }
      it { _(subject.remaining).must_equal '' }
    end
  end

  describe '#contains_emoji?' do
    describe 'includes an emoji' do
      let(:text) { '👍' }
      it { _(subject).must_be :contains_emoji? }
    end

    describe 'not include any emoji' do
      let(:text) { 'text only' }
      it { _(subject).wont_be :contains_emoji? }
    end
  end

  describe '#left_with_emoji' do
    let(:text) { 'aaaaaa📌bbbbbb' }
    it { _(subject.left_with_emoji).must_equal 'aaaaaa📌' }
  end

  describe '#to_s' do
    let(:text) { 'aaaaaa📌bbbbbb' }
    it { _(subject.to_s).must_equal text }
  end
end
