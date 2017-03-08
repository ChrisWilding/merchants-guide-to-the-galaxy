require 'spec_helper'

RSpec.describe Merchant::Commodity do
  let(:name) { 'Sausages' }
  subject { described_class.new(450, 4950, name) }

  it 'has a name' do
    expect(subject.name).to eq(name)
  end

  it 'returns the unit price in credits' do
    expect(subject.credits).to eq(11)
  end
end
