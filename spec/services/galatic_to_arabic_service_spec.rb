require 'spec_helper'

RSpec.describe Merchant::GalacticToArabicService do
  subject do
    galactic_to_roman_service = Merchant::GalacticToRomanService.new
    nodes = [
      Merchant::TranslationDefinition.new('glob', 'I'),
      Merchant::TranslationDefinition.new('prok', 'V'),
      Merchant::TranslationDefinition.new('pish', 'X'),
      Merchant::TranslationDefinition.new('tegj', 'L')
    ]
    nodes.each { |node| galactic_to_roman_service.process(node) }
    described_class.new(galactic_to_roman_service)
  end

  context 'handles?' do
    it 'returns true for TranslationQuery nodes' do
      node = Merchant::TranslationQuery.new('glob')
      expect(subject.handles?(node)).to be_truthy
    end

    it 'returns false for other nodes' do
      node = Merchant::UnknownDefinitionOrQuery.new
      expect(subject.handles?(node)).to be_falsey
    end
  end

  it 'converts galactic numerals to arabic' do
    expect(subject.convert('tegj pish prok glob')).to eq(66)
  end

  [
    [
      Merchant::TranslationQuery.new('pish tegj glob glob'),
      'pish tegj glob glob is 42'
    ],
    [
      Merchant::TranslationQuery.new('glob glob'),
      'glob glob is 2'
    ]
  ].each do |node, expected|
    it 'process returns the galactic numeral value in arabic numerals' do
      expect(subject.process(node)).to eq(expected)
    end
  end
end
