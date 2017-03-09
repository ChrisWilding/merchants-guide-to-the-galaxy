require 'spec_helper'

RSpec.describe Merchant::CommodityPriceService do
  context 'when the parser can parse the string' do
    it 'handles? method returns true' do
      parser = double('parser')
      allow(parser).to receive(:can_parse?).and_return(true)
      service = described_class.new(nil, nil, parser)
      expect(service.handles?('FAKE')).to be_truthy
    end
  end

  context 'when the parser can not parse the string' do
    it 'handles? method returns true' do
      parser = double('parser')
      allow(parser).to receive(:can_parse?).and_return(false)
      subject = described_class.new(nil, nil, parser)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end

  subject do
    translator = Merchant::GalaticToRomanService.new
    translator.process('glob is I')
    translator.process('prok is V')
    galatic_to_arabic_service = Merchant::GalaticToArabicService.new(translator)
    price_definition_service = Merchant::PriceDefinitionService.new(galatic_to_arabic_service)
    price_definition_service.process('glob glob Silver is 34 Credits')
    described_class.new(galatic_to_arabic_service, price_definition_service)
  end

  it 'process calculates the unit price in credits for a commodity' do
    result = subject.process('how many Credits is glob prok Silver ?')
    expect(result).to eq('glob prok Silver is 68 Credits')
  end
end
