require 'spec_helper'

RSpec.describe Merchant::GalacticToArabicService do
  subject do
    galactic_to_roman_service = Merchant::GalacticToRomanService.new
    ['glob is I', 'prok is V', 'pish is X', 'tegj is L'].each do |example|
      galactic_to_roman_service.process(example)
    end
    described_class.new(galactic_to_roman_service)
  end

  it 'converts galactic numerals to arabic' do
    expect(subject.convert('tegj pish prok glob')).to eq(66)
  end

  it 'process returns how much the galactic numeral is' do
    result = subject.process('how much is pish tegj glob glob ?')
    expect(result).to eq('pish tegj glob glob is 42')
  end

  context 'handles?' do
    let(:parser) { double('parser') }
    subject { described_class.new(nil, parser) }

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
