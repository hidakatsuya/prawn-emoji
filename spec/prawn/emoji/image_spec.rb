require 'spec_helper'

describe Prawn::Emoji::Image do
  let(:emojis) { %w( 😀 © ) }

  it 'possible to find the image file' do
    emojis.each do |emoji|
      emoji_image = Prawn::Emoji::Image.new(emoji)
      expect(File.exist?(emoji_image.path)).to be_truthy
    end
  end
end
