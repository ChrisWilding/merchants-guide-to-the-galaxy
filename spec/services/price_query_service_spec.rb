require 'spec_helper'

RSpec.describe Merchant::PriceQueryService do
  subject do
    galactic_to_roman_service = Merchant::GalacticToRomanService.new
    galactic_to_roman_service.process(
      Merchant::TranslationDefinition.new('glob', 'I')
    )
    galactic_to_roman_service.process(
      Merchant::TranslationDefinition.new('prok', 'V')
    )
    galactic_to_arabic_service = Merchant::GalacticToArabicService.new(
      galactic_to_roman_service
    )
    price_definition_service = Merchant::PriceDefinitionService.new(
      galactic_to_arabic_service
    )
    price_definition_service.process(
      Merchant::PriceDefinition.new('glob glob', 'Silver', '34')
    )
    described_class.new(galactic_to_arabic_service, price_definition_service)
  end

  context 'handles?' do
    it 'returns true for PriceQuery nodes' do
      node = Merchant::PriceQuery.new('glob glob', 'Silver')
      expect(subject.handles?(node)).to be_truthy
    end

    it 'returns false for other nodes' do
      node = Merchant::UnknownDefinitionOrQuery.new
      expect(subject.handles?(node)).to be_falsey
    end
  end

  it 'process calculates the unit price in credits for a commodity' do
    node = Merchant::PriceQuery.new('glob prok', 'Silver')
    expect(subject.process(node)).to eq('glob prok Silver is 68 Credits')
  end
end
