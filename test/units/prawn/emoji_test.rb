# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji do
  describe '.regex' do
    subject { Prawn::Emoji.regex }

    describe 'Default' do
      it { _(subject).must_equal ::Unicode::Emoji::REGEX_VALID }
    end

    describe 'Custom' do
      let(:custom_regex) { ::Unicode::Emoji::REGEX_INCLUDE_TEXT }

      before { stub(Prawn::Emoji.config).regex { custom_regex } }

      it { _(subject).must_equal custom_regex }
    end
  end
end
