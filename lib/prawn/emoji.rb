# frozen_string_literal: true

require 'prawn'
require 'pathname'

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
