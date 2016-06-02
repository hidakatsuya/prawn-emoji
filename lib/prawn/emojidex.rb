require 'emojidex/data/utf'
require 'emojidex-rasters'

module Prawn
  module EmojidexEmoji
    def self.init_emojidex
      @utf = Emojidex::Data::UTF.new
    end

    def self.source_path
      @utf.raster_source_path
    end

    def self.collection
      @utf
    end

    def self.unicodes
      @unicodes ||= build_unicodes
    end

    def self.build_unicodes
      @unicodes = @utf.map { |emoji| emoji.unicode }
    end
  end
end
