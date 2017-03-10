require 'spec_helper'

RSpec.describe Merchant::CommodityPriceService do
  subject do
    galatic_to_roman_service = Merchant::GalaticToRomanService.new
    galatic_to_roman_service.process('glob is I')
    galatic_to_roman_service.process('prok is V')
    galatic_to_arabic_service = Merchant::GalaticToArabicService.new(
      galatic_to_roman_service
    )
    price_definition_service = Merchant::PriceDefinitionService.new(
      galatic_to_arabic_service
    )
    price_definition_service.process('glob glob Silver is 34 Credits')
    described_class.new(galatic_to_arabic_service, price_definition_service)
  end

  it 'process calculates the unit price in credits for a commodity' do
    result = subject.process('how many Credits is glob prok Silver ?')
    expect(result).to eq('glob prok Silver is 68 Credits')
  end

  context 'handles?' do
    let(:parser) { double('parser') }
    subject { described_class.new(nil, nil, parser) }

    it 'returns true when the parser can parse' do
      allow(parser).to receive(:can_parse?).and_return(true)
      expect(subject.handles?('FAKE')).to be_truthy
    end

    it 'return false when the parser can not parse' do
      allow(parser).to receive(:can_parse?).and_return(false)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end
end
