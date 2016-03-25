require 'spec_helper'

describe 'use emojidex emoji' do
  before(:all) do
    @cache_path = File.expand_path('../../../tmp', __FILE__)
    @sushi = { name: 'sushi', unicode: '1f363' }
  end

  it 'init emojidex (create emojidex collection)' do
    Prawn::EmojidexEmoji.init_emojidex(@cache_path)
    expect(Prawn::EmojidexEmoji.collection).to be_an_instance_of(Emojidex::Data::UTF)
  end

  it 'cache emojidex emoji' do
    Prawn::EmojidexEmoji.cache
    expect(File.exist?("#{@cache_path}/emoji/px64/#{@sushi[:name]}.png")).to be_truthy
  end

  it 'get emojidex unicodes' do
    expect(Prawn::EmojidexEmoji.unicodes.include?(@sushi[:unicode])).to be_truthy
  end

  after(:all) { FileUtils.rm_r(@cache_path) }
end
