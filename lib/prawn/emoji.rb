# frozen_string_literal: true

require 'prawn'
require 'unicode/emoji'
require 'pathname'

module Prawn
  module Emoji
    Config = Struct.new(
      # Emoji Regex
      #
      # The following values are available (Default is `Unicode::Emoji::REGEX_VALID`):
      # https://github.com/janlelis/unicode-emoji#regex.
      :regex
    )
    def self.config
      @config ||= Config.new(::Unicode::Emoji::REGEX_VALID)
    end

    def self.regex
      config.regex
    end

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
