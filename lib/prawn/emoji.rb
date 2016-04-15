require 'prawn'
require 'pathname'
require 'prawn/emojidex'

module Prawn
  module Emoji
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
Prawn::EmojidexEmoji::init_emojidex
Prawn::EmojidexEmoji::cache
