# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new('test:units') do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/units/**/*_test.rb']
  t.warning = false
end

Rake::TestTask.new('test:pdf') do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/pdf/*/test_case.rb']
  t.warning = false
end

desc 'Run all unit and pdf tests'
task test: %i( test:units test:pdf )

namespace :emoji do
  desc 'Update emoji'
  task update: %i( clean_all twemoji:load update_index )

  desc 'Update emoji/index.yml from emoji/images'
  task :update_index do
    require 'prawn/emoji'
    require 'yaml'

    emoji_files = Prawn::Emoji.root.join('emoji', 'images', '*.png')
    emoji_names = Pathname.glob(emoji_files).map { |f| f.basename('.png').to_s }

    index_file  = Prawn::Emoji.root.join('emoji', 'index.yml')
    index_file.write emoji_names.sort.to_yaml

    puts 'Updated index.yml'
  end

  desc 'Clean all emojis'
  task :clean_all do
    require 'prawn/emoji'
    require 'fileutils'

    FileUtils.rm(Prawn::Emoji.root.join('emoji', 'images').glob('*.png'))

    puts 'Cleaned'
  end

  namespace :twemoji do
    desc 'Load and put github.com/twitter/twemoji/2/72x72/*.png in the emoji/images/'
    task :load do
      require 'prawn/emoji'
      require 'open-uri'
      require 'zip'
      require 'tempfile'

      image_dir = Prawn::Emoji.root.join('emoji', 'images')

      puts 'Loading source of github.com/twitter/twemoji...'

      master_zip = Tempfile.open do |t|
        t.binmode
        t.write open('https://github.com/twitter/twemoji/archive/gh-pages.zip').read
        t
      end

      puts 'Loaded'

      Zip::File.open(master_zip.path) do |master|
        emojis = master.glob('twemoji-gh-pages/2/72x72/*.png')

        puts "Saving #{emojis.size} emoji files..."
        emojis.each do |image|
          emoji_name = EmojiName.new(File.basename(image.name))
          image_dir.join(emoji_name.name).binwrite(image.get_input_stream.read)
        end
      end
    end

    class EmojiName
      attr_reader :original_name

      def initialize(original_name)
        @original_name = original_name
      end

      def name
        @name ||= convert
      end

      private

      def convert
        codepoints = original_name.gsub('.png', '').split('-')
        Prawn::Emoji::Unicode.format_codepoint(codepoints) + '.png'
      end
    end
  end
end
