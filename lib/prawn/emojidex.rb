require 'emojidex/data/utf'
require 'emojidex-vectors'
# require 'emojidex-rasters'

module Prawn
  module EmojidexEmoji
    def self.init_emojidex(cache_path = Emojidex::Defaults::system_cache_path)
      if File.exist?("#{cache_path}/emoji/emoji.json")
        options = {cache_path: cache_path, local_load_path: "#{cache_path}/emoji"}
      else
        options = {cache_path: cache_path}
      end
      @utf = Emojidex::Data::UTF.new options
    end

    def self.cache(formats = [:svg], sizes = [:px64], cache_path = Emojidex::Defaults::system_cache_path)
    # def self.cache(formats = [:png], sizes = [:px64], cache_path = Emojidex::Defaults::system_cache_path)
      @utf.cache!({formats: formats, sizes: sizes, cache_path: cache_path})
    end

    def self.cache_path
      @utf.cache_path
    end

    def self.collection
      @utf
    end
  end
end
