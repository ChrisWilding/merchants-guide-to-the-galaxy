require 'spec_helper'

RSpec.describe Merchant::PriceDefinitionService do
  context 'when the parser can parse the string' do
    it 'handles? method returns true' do
      parser = double('parser')
      allow(parser).to receive(:can_parse?).and_return(true)
      service = described_class.new(nil, parser)
      expect(service.handles?('FAKE')).to be_truthy
    end
  end

  context 'when the parser can not parse the string' do
    it 'handles? method returns true' do
      parser = double('parser')
      allow(parser).to receive(:can_parse?).and_return(false)
      subject = described_class.new(nil, parser)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end

  subject do
    translator = Merchant::GalaticToRomanService.new
    translator.process('glob is I')
    galatic_to_arabic_service = Merchant::GalaticToArabicService.new(translator)
    described_class.new(galatic_to_arabic_service)
  end

  it 'process calculates the unit price in credits for a commodity' do
    subject.process('glob glob Silver is 34 Credits')
    expect(subject.price_of('Silver')).to eq(17)
  end
end
