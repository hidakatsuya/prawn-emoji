require 'emojidex/data/utf'
require 'emojidex-rasters'

module Prawn
  module EmojidexEmoji
    def self.init_emojidex(cache_path = Emojidex::Defaults::system_cache_path)
      options = { cache_path: cache_path }
      options[:local_load_path] = "#{cache_path}/emoji" if File.exist?("#{cache_path}/emoji/emoji.json")
      @utf = Emojidex::Data::UTF.new options
    end

    def self.cache(formats = [:png], sizes = [:px64], cache_path = Emojidex::Defaults::system_cache_path)
      @utf.cache!({ formats: formats, sizes: sizes, cache_path: cache_path })
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
