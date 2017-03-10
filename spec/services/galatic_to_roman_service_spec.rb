require 'spec_helper'

RSpec.describe Merchant::GalacticToRomanService do
  context 'handles?' do
    let(:parser) { double('parser') }
    subject { described_class.new(parser) }

    it 'returns true when the parser can parse' do
      allow(parser).to receive(:can_parse?).and_return(true)
      expect(subject.handles?('FAKE')).to be_truthy
    end

    it 'return false when the parser can not parse' do
      allow(parser).to receive(:can_parse?).and_return(false)
      expect(subject.handles?('FAKE')).to be_falsey
    end
  end

  context 'process' do
    it 'returns nil' do
      result = subject.process('glob is I')
      expect(result).to be_nil
    end
  end

  context 'when it has processed the examples' do
    before do
      ['glob is I', 'prok is V', 'pish is X', 'tegj is L'].each do |example|
        subject.process(example)
      end
    end

    it 'transalates a galactic numeral' do
      expect(subject.translate_numeral('pish')).to eq('X')
    end

    it 'transalates a string of galactic numeral' do
      str = 'pish tegj prok glob'
      expect(subject.translate_numerals(str)).to eq('XLVI')
    end
  end

  it 'raises an error when it can not translate a galactic numeral' do
    expect { subject.translate_numeral('BANG') }.to raise_error(
      'Can not translate invalid numeral BANG'
    )
  end
end
