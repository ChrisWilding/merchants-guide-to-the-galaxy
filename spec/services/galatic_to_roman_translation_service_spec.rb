require 'spec_helper'

RSpec.describe Merchant::GalaticToRomanTranslationService do
  let(:parser) { double('parser') }

  context 'when the parser can parse the string' do
    it 'handles? method returns true' do
      allow(parser).to receive(:can_parse?).and_return(true)
      service = described_class.new({}, parser)
      expect(service.handles?('FAKE')).to be_truthy
    end
  end

  context 'when the parser can not parse the string' do
    it 'handles? method returns true' do
      allow(parser).to receive(:can_parse?).and_return(false)
      subject = described_class.new({}, parser)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end

  context 'when process is called' do
    it 'calls the parse on the parser' do
      expect(parser).to receive(:parse).with('TEST').and_return(%w(a b))
      service = described_class.new({}, parser)
      service.process('TEST')
    end
  end

  context 'when it has processed the examples' do
    before do
      ['glob is I', 'prok is V', 'pish is X', 'tegj is L'].each do |example|
        subject.process(example)
      end
    end

    it 'transalate a galatic numeral' do
      expect(subject.translate_numeral('pish')).to eq('X')
    end

    it 'transalates a string of galatic numeral' do
      str = 'pish tegj prok glob'
      expect(subject.translate_numerals(str)).to eq('XLVI')
    end
  end

  it 'raises an error when it can not translate a galatic numeral' do
    expect { subject.translate_numeral('BANG') }.to raise_error('Can not translate invalid numeral BANG')
  end
end
