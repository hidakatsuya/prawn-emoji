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
    before  { stub(index).unicodes { %w( 00A9 00AE ) } }

    it { subject.must_equal(/\u{00A9}|\u{00AE}/) }
  end
end
