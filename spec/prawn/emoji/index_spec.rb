require 'spec_helper'
require 'emojidex/data/utf'

describe Prawn::Emoji::Index do
  let(:index) { Prawn::Emoji::Index.new }
  let(:origin_index) { Emojidex::Data::UTF.new.map { |emoji| emoji.unicode } }

  describe '#unicodes' do
    subject { index.unicodes }
    it { expect(subject).to eq origin_index }
  end

  describe '#unicodes_regexp' do
    subject { index.unicodes_regexp }
    before { allow(index).to receive(:unicodes).and_return(%w( 00A9 00AE )) }

    it { expect(subject).to match /\u{00A9}|\u{00AE}/ }
  end

  describe '#surrogate_pair' do
    subject { index.surrogate_pair }
    it { expect(subject).to include '1f600-1f3fb' }
  end
end
