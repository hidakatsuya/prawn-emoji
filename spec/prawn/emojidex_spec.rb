require 'spec_helper'

describe 'use emojidex emoji' do
  before(:all) do
    # It has already been created cache in spec_helper configue.
    FileUtils.rm_r spec_cache_path

    @sushi = { name: 'sushi', unicode: '1f363' }
  end

  it 'init emojidex (create emojidex collection)' do
    Prawn::EmojidexEmoji.init_emojidex spec_cache_path
    expect(Prawn::EmojidexEmoji.collection).to be_an_instance_of Emojidex::Data::UTF
  end

  it 'cache emojidex emoji' do
    Prawn::EmojidexEmoji.cache
    expect(File.exist?("#{spec_cache_path}/emoji/px64/#{@sushi[:name]}.png")).to be_truthy
  end

  it 'get emojidex unicodes' do
    expect(Prawn::EmojidexEmoji.unicodes).to include @sushi[:unicode]
  end
end
