# frozen_string_literal: true

require 'units/test_helper'
require 'yaml'

describe Prawn::Emoji::Index do
  let(:index) { Prawn::Emoji::Index.new }

  describe '#codepoints' do
    subject { index.codepoints }

    let(:all_codes) { YAML.load_file(Prawn::Emoji.root.join('emoji', 'index.yml')) }

    it { subject.must_equal all_codes }
  end

  describe '#include?' do
    it { index.include?('0023-20e3').must_equal true }
    it { index.include?('3299').must_equal true }
    it { index.include?('unknown').must_equal false }
  end
end
