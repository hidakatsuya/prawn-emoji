require 'spec_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    subject { Prawn::Emoji::Image.new('😀').path }

    it { subject.must_equal Prawn::Emoji.root.join('emoji', 'images', '1F600.png').to_s }
  end
end
