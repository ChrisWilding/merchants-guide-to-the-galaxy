require 'spec_helper'

RSpec.describe Merchant::PriceDefinitionService do
  subject do
    galactic_to_roman_service = Merchant::GalacticToRomanService.new
    galactic_to_roman_service.process(
      Merchant::TranslationDefinition.new('glob', 'I')
    )
    galactic_to_arabic_service = Merchant::GalacticToArabicService.new(
      galactic_to_roman_service
    )
    described_class.new(galactic_to_arabic_service)
  end

  context 'handles?' do
    it 'returns true for PriceDefinition nodes' do
      node = Merchant::PriceDefinition.new('glob', 'Silver', '38')
      expect(subject.handles?(node)).to be_truthy
    end

    it 'returns false for other nodes' do
      node = Merchant::UnknownDefinitionOrQuery.new
      expect(subject.handles?(node)).to be_falsey
    end
  end

  context 'process' do
    let!(:result) do
      node = Merchant::PriceDefinition.new('glob glob', 'Silver', '34')
      subject.process(node)
    end

    it 'calculates the unit price in credits for a commodity' do
      expect(subject.price_of('Silver')).to eq(17)
    end

    it 'returns nil' do
      expect(result).to be_nil
    end
  end
end
