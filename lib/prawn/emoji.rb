# frozen_string_literal: true

require 'prawn'
require 'pathname'
require 'unicode/emoji'

module Prawn
  module Emoji
    REGEX = ::Unicode::Emoji::REGEX_VALID

    def self.root
      @root ||= Pathname.new File.expand_path('../..', File.dirname(__FILE__))
    end

    def self.extended(object)
      object.extend Drawable
    end
  end
end

require_relative 'emoji/version'
require_relative 'emoji/drawable'

Prawn::Document.extensions << Prawn::Emoji
