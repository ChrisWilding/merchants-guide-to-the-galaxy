RSpec.describe Merchant::CommodityConversion do
  subject do
    described_class.new('Silver', 'Gold', 'glob')
  end

  it 'has a from commodity property' do
    expect(subject.from_commodity).to eq('Silver')
  end

  it 'has a to commodity property' do
    expect(subject.to_commodity).to eq('Gold')
  end

  it 'has a galactic property' do
    expect(subject.galactic).to eq('glob')
  end
end
