require 'spec_helper'

RSpec.describe Merchant::Parser do
  it 'parses a translation definition' do
    parser = described_class.new('prok is V')
    translation_definition = parser.parse.first
    expect(translation_definition.galactic).to eq('prok')
    expect(translation_definition.roman).to eq('V')
  end

  it 'parses a price definition' do
    parser = described_class.new('glob glob Silver is 34 Credits')
    price_definition = parser.parse.first
    expect(price_definition.galactic).to eq('glob glob')
    expect(price_definition.commodity).to eq('Silver')
    expect(price_definition.credits).to eq('34')
  end

  it 'parses a translation query' do
    parser = described_class.new('how much is pish tegj glob glob ?')
    translation_query = parser.parse.first
    expect(translation_query.galactic).to eq('pish tegj glob glob')
  end

  it 'parses a price query' do
    parser = described_class.new('how many Credits is glob prok Silver ?')
    price_query = parser.parse.first
    expect(price_query.galactic).to eq('glob prok')
    expect(price_query.commodity).to eq('Silver')
  end

  it 'parses an unknown definition or query' do
    parser = described_class.new(
      'how much wood could a woodchuck chuck if a woodchuck could chuck wood ?'
    )
    unknown_definition_or_query = parser.parse.first
    expect(unknown_definition_or_query).to be_a(
      Merchant::UnknownDefinitionOrQuery
    )
  end

  it 'parses multiple items' do
    parser = described_class.new("tegj is L\nglob glob Silver is 34 Credits")
    translation_definition, price_definition = parser.parse
    expect(translation_definition.galactic).to eq('tegj')
    expect(translation_definition.roman).to eq('L')
    expect(price_definition.galactic).to eq('glob glob')
    expect(price_definition.commodity).to eq('Silver')
    expect(price_definition.credits).to eq('34')
  end
end
