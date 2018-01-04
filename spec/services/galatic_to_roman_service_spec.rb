require 'spec_helper'

RSpec.describe Merchant::GalacticToRomanService do
  context 'handles?' do
    it 'returns true for TranslationDefinition nodes' do
      node = Merchant::TranslationDefinition.new('glob', 'I')
      expect(subject.handles?(node)).to be_truthy
    end

    it 'returns false for other nodes' do
      node = Merchant::UnknownDefinitionOrQuery.new
      expect(subject.handles?(node)).to be_falsey
    end
  end

  it 'process returns nil' do
    node = Merchant::TranslationDefinition.new('glob', 'I')
    expect(subject.process(node)).to be_nil
  end

  context 'when it has processed the nodes' do
    before do
      nodes = [
        Merchant::TranslationDefinition.new('glob', 'I'),
        Merchant::TranslationDefinition.new('prok', 'V'),
        Merchant::TranslationDefinition.new('pish', 'X'),
        Merchant::TranslationDefinition.new('tegj', 'L')
      ]

      nodes.each { |node| subject.process(node) }
    end

    it 'transalates a galactic numeral' do
      expect(subject.translate_numeral('pish')).to eq('X')
    end

    it 'transalates a string of galactic numerals' do
      str = 'pish tegj prok glob'
      expect(subject.translate_numerals(str)).to eq('XLVI')
    end
  end

  it 'raises an error when it can not translate a galactic numeral' do
    expect { subject.translate_numeral('BANG') }.to raise_error(
      'Can not translate invalid numeral BANG'
    )
  end
end
