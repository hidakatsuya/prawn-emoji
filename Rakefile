require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end

task default: :test

namespace :emoji do
  desc 'Generate emoji/index.yml from emoji/images'
  task :generate_index do
    require 'prawn/emoji'
    require 'yaml'

    emoji_files = Prawn::Emoji.root / 'emoji' / 'images' / '*.png'
    emoji_names = Pathname.glob(emoji_files).map { |f| f.basename('.png').to_s }

    index_file  = Prawn::Emoji.root / 'emoji' / 'index.yml'
    index_file.write emoji_names.to_yaml
  end
end
