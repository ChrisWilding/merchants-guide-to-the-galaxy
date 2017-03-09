require 'spec_helper'

RSpec.describe Merchant::PriceDefinitionService do
  subject do
    galatic_to_roman_service = Merchant::GalaticToRomanService.new
    galatic_to_roman_service.process('glob is I')
    galatic_to_arabic_service = Merchant::GalaticToArabicService.new(galatic_to_roman_service)
    described_class.new(galatic_to_arabic_service)
  end

  context 'handles?' do
    let(:parser) { double('parser') }

    it 'returns false when the parser can not parse' do
      allow(parser).to receive(:can_parse?).and_return(true)
      service = described_class.new(nil, parser)
      expect(service.handles?('FAKE')).to be_truthy
    end

    it 'return true when the parser can parse' do
      allow(parser).to receive(:can_parse?).and_return(false)
      subject = described_class.new(nil, parser)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end

  context 'process' do
    it 'calculates the unit price in credits for a commodity' do
      subject.process('glob glob Silver is 34 Credits')
      expect(subject.price_of('Silver')).to eq(17)
    end

    it 'returns nil' do
      result = subject.process('glob glob Silver is 34 Credits')
      expect(result).to be_nil
    end
  end
end
