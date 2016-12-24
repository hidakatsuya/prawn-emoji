require 'test_helper'
require 'yaml'

describe Prawn::Emoji::Index do
  let(:index) { Prawn::Emoji::Index.new }

  describe '#unicodes' do
    subject { index.unicodes }
    it { subject.must_equal YAML.load Prawn::Emoji.root.join('emoji', 'index.yml').read }
  end

  describe '#unicodes_regexp' do
    subject { index.unicodes_regexp }
    before  { stub(index).unicodes { %w( 00a9 00ae 002a-20e3 ) } }

    it { subject.must_equal(/\u{00a9}|\u{00ae}|\u{002a 20e3}/) }
  end
end
