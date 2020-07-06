# frozen_string_literal: true

require 'units/test_helper'

describe Prawn::Emoji::Drawable do
  class DocumentTest
    def draw_text!(text, options); end
  end

  let(:document_test) { DocumentTest.new.extend Prawn::Emoji::Drawable }

  describe '#draw_text!(text, options)' do
    subject { document_test.draw_text!(text, options) }

    describe 'the :emoji option is set true' do
      let(:options) { { emoji: true } }

      describe 'the text includes an emoji' do
        let(:text) { 'text🍣' }

        it 'calls Emoji::Drawer#draw' do
          mock(document_test.send(:emoji_drawer)).draw(text, options).once
          subject
        end
      end

      describe 'the text does not include any emoji' do
        let(:text) { 'text' }

        it 'never calls Emoji::Drawer#draw' do
          mock(document_test.send(:emoji_drawer)).draw(text, options).never
          subject
        end
      end

      describe 'the text encoding is not utf-8' do
        let(:text) { 'text'.encode('ascii-8bit') }

        it 'never calls Emoji::Drawer#draw' do
          mock(document_test.send(:emoji_drawer)).draw(text, options).never
          subject
        end
      end

      describe 'the text is empty' do
        let(:text) { '' }

        it 'never calls Emoji::Drawer#draw' do
          mock(document_test.send(:emoji_drawer)).draw(text, options).never
          subject
        end
      end
    end

    describe 'the :emoji option is set false' do
      let(:options) { { emoji: false } }
      let(:text) { 'text🍣' }

      it 'never calls Emoji::Drawer#draw' do
        mock(document_test.send(:emoji_drawer)).draw(text, options).never
        document_test.draw_text!(text, options)
      end
    end

    describe 'the :emoji option is not set' do
      let(:options) { { } }
      let(:text) { 'text🍣' }

      it 'calls Emoji::Drawer#draw' do
        mock(document_test.send(:emoji_drawer)).draw(text, options).once
        document_test.draw_text!(text, options)
      end
    end
  end
end
