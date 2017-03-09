require 'spec_helper'

RSpec.describe Merchant::Commodity do
  let(:name) { 'Sausages' }
  subject { described_class.new(450, name, 4950) }

  it 'has a name' do
    expect(subject.name).to eq(name)
  end

  it 'returns the unit price in credits' do
    expect(subject.credits).to eq(11)
  end

  context 'when the unit price is a decimal' do
    subject { described_class.new(4, name, 782) }

    it 'returns the price as a decimal' do
      expect(subject.credits).to eq(BigDecimal.new('195.5'))
    end
  end
end
