# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Substitution do
  let(:document) { Prawn::Document.new }
  let(:font_size) { 12 }
  let(:substitution) { Prawn::Emoji::Substitution.new(document) }

  before do
    document.font(font) if font
    document.font_size = 12
  end

  subject { substitution.to_s }

  describe 'When Japanese TTF font' do
    let(:font) { Prawn::Emoji.root.join('test', 'fonts', 'ipag.ttf') }

    it { subject.must_equal '　' }
    it { document.width_of(subject).must_equal font_size }
  end

  describe 'When ASCII TTF font' do
    let(:font) { Prawn::Emoji.root.join('test', 'fonts', 'DejaVuSans.ttf') }

    it { subject.must_match /^#{Prawn::Text::NBSP}+$/ }
    it { document.width_of(subject).must_be :>=, font_size - 1 }
    it { document.width_of(subject).must_be :<=, font_size + 1 }
  end

  describe 'When built-in AFM font' do
    let(:font) { nil }

    it { proc { subject }.must_raise Prawn::Errors::IncompatibleStringEncoding }
  end
end
