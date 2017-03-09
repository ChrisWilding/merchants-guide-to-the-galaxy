require 'spec_helper'

RSpec.describe Merchant::GalaticToArabicService do
  subject do
    translator = Merchant::GalaticToRomanService.new
    ['glob is I', 'prok is V', 'pish is X', 'tegj is L'].each do |example|
      translator.process(example)
    end
    described_class.new(translator)
  end

  it 'converts galatic numerals to arabic' do
    expect(subject.convert('tegj pish prok glob')).to eq(66)
  end

  it 'process returns how much the galatic numeral is' do
    result = subject.process('how much is pish tegj glob glob ?')
    expect(result).to eq('pish tegj glob glob is 42')
  end

  context 'when the parser can parse the string' do
    let(:parser) { double('parser') }
    it 'handles? method returns true' do
      allow(parser).to receive(:can_parse?).and_return(true)
      service = described_class.new(nil, parser)
      expect(service.handles?('FAKE')).to be_truthy
    end
  end

  context 'when the parser can not parse the string' do
    let(:parser) { double('parser') }
    it 'handles? method returns true' do
      allow(parser).to receive(:can_parse?).and_return(false)
      subject = described_class.new(nil, parser)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end
end
