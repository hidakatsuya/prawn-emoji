require 'test_helper'
require 'yaml'

describe Prawn::Emoji::Index do
  let(:index) { Prawn::Emoji::Index.new }

  describe '#codepoints' do
    subject { index.codepoints }

    let(:all_codes) { YAML.load_file(Prawn::Emoji.root.join('emoji', 'index.yml')) }
    # Expect to excludes ASCII characters and symbols
    let(:exclusion_codes) { (0x21..0x7e).map { |code| '%04x' % code }.map(&:downcase) }

    it { subject.must_equal all_codes - exclusion_codes }
  end

  describe '#to_regexp' do
    subject { index.to_regexp }
    before  { stub(index).codepoints { %w( 00a9 00ae 002a-20e3 ) } }

    it { subject.must_equal(/\u{00a9}|\u{00ae}|\u{002a 20e3}/) }
  end
end
