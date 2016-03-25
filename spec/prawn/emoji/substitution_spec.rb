require 'spec_helper'

describe Prawn::Emoji::Substitution do
  let(:document) { Prawn::Document.new }
  let(:substitution) { Prawn::Emoji::Substitution.new(document) }

  subject { substitution.to_s }

  describe 'full-size-space is used' do
    before do
      document.font_size = 12
      allow(substitution).to receive(:full_size_space_width).and_return(12)
    end

    it { expect(subject).to eq '　' }
  end

  describe 'half-size-space is used' do
    before do
      document.font_size = 12
      allow(substitution).to receive(:full_size_space_width).and_return(11.9)
    end

    it { expect(subject).to eq Prawn::Text::NBSP }
  end
end
