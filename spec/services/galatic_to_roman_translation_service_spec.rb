require 'spec_helper'

RSpec.describe Merchant::GalaticToRomanTranslationService do
  subject do
    mapping = {
      'glob' => 'I',
      'prok' => 'V',
      'pish' => 'X',
      'tegj' => 'L'
    }
    described_class.new(mapping)
  end

  it 'converts a galatic number to a roman numeral' do
    expect(subject.convert('glob prok')).to eq('IV')
  end

  it 'raises an error when conversion fails' do
    expect { subject.convert('pish BANG') }.to raise_error('Invalid galatic numeral BANG')
  end
end
