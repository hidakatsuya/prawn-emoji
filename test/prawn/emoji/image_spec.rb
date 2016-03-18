require 'test_helper'

describe Prawn::Emoji::Image do
  describe '#path' do
    def image_path_for(emoji)
      Prawn::Emoji::Image.new(emoji).path
    end

    it { image_path_for('😀').must_equal Prawn::Emoji.root.join('emoji', 'images', '1F600.png').to_s }
    it { image_path_for('©').must_equal Prawn::Emoji.root.join('emoji', 'images', '00A9.png').to_s }
  end
end
