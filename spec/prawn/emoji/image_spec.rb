require 'spec_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    subject { Prawn::Emoji::Image.new('😀').path }

    it { expect(subject).to eq "#{spec_cache_path}/emoji/px64/grinning.png" }
  end
end
