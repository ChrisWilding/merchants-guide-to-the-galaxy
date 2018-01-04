require 'spec_helper'

RSpec.describe Merchant::PriceQuery do
  subject do
    described_class.new('glob glob', 'Silver')
  end

  it 'has a commodity property' do
    expect(subject.commodity).to eq('Silver')
  end

  it 'has a galactic property' do
    expect(subject.galactic).to eq('glob glob')
  end
end
