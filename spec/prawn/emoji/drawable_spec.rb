require 'spec_helper'

describe Prawn::Emoji::Drawable do
  class DocumentTest
    def draw_text!(text, options); end
  end

  let(:document_test) { DocumentTest.new.extend Prawn::Emoji::Drawable }

  describe '#draw_text!' do
    it 'calls Emoji::Drawer#draw before processing self' do
      allow_any_instance_of(Prawn::Emoji::Drawer) do |drawer|
        mock(drawer).draw('text', { option: 'value' }).once
      end
      document_test.draw_text!('text', option: 'value')
    end
  end

  describe '#emoji_drawer' do
    subject { document_test.send :emoji_drawer }
    it { expect(subject).to be_instance_of Prawn::Emoji::Drawer }
  end
end
