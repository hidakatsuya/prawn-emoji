require 'emojidex/data/utf'
require 'emojidex-rasters'

module Prawn
  module EmojidexEmoji
    def self.init_emojidex(cache_path = Emojidex::Defaults::system_cache_path)
      @utf = Emojidex::Data::UTF.new(cache_path: cache_path)
    end

    def self.cache(formats = [:png], sizes = [:px64])
      @utf.cache!({ formats: formats, sizes: sizes })
    end

    def self.cache_path
      @utf.cache_path
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
