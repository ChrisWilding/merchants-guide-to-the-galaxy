require 'spec_helper'

RSpec.describe Merchant::TranslationDefinition do
  subject do
    described_class.new('prok', 'V')
  end

  it 'has a galactic property' do
    expect(subject.galactic).to eq('prok')
  end

  it 'has a roman property' do
    expect(subject.roman).to eq('V')
  end
end
