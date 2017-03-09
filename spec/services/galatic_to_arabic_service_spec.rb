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
end
