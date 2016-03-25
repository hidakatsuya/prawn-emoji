require 'spec_helper'

describe Prawn::Emoji::Substitution do
  let(:document) { Prawn::Document.new }
  let(:substitution) { Prawn::Emoji::Substitution.new(document) }

  subject { substitution.to_s }

  describe 'full-size-space is used' do
    before do
      document.font_size = 12
      stub(substitution).full_size_space_width { 12 }
    end

    it { subject.must_equal '　' }
  end

  describe 'half-size-space is used' do
    before do
      document.font_size = 12
      stub(substitution).full_size_space_width { 11.99 }
    end

    it { subject.must_equal Prawn::Text::NBSP }
  end
end
