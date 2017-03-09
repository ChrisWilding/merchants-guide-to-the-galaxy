require 'spec_helper'

RSpec.describe Merchant::RomanToArabicConverter do
  examples = {
    'I' => 1,
    'II' => 2,
    'III' => 3,
    'IV' => 4,
    'V' => 5,
    'VI' => 6,
    'IX' => 9,
    'XXVII' => 27,
    'XLVIII' => 48,
    'LIX' => 59,
    'XCIII' => 93,
    'CXXIII' => 123,
    'CXLI' => 141,
    'CLXIII' => 163,
    'CDII' => 402,
    'DLXXV' => 575,
    'CMXI' => 911,
    'MXXIV' => 1024,
    'MMM' => 3000,
    'MMMCMXCIX' => 3999
  }

  examples.each do |roman, arabic|
    it "converts #{roman} to #{arabic}" do
      expect(subject.convert(roman)).to eq(arabic)
    end
  end

  it 'raises an error converting invalid roman numerals' do
    expect { subject.convert('MMMM') }.to raise_error('Can not convert roman numeral MMMM to arabic')
  end
end
