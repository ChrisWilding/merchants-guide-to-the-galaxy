
require 'spec_helper'

RSpec.describe Merchant::UnknownDefinitionOrQueryService do
  context 'handles?' do
    it 'returns true for UnknownDefinitionOrQuery nodes' do
      node = Merchant::UnknownDefinitionOrQuery.new
      expect(subject.handles?(node)).to be_truthy
    end

    it 'returns false for other nodes' do
      node = Merchant::PriceQuery.new('glob glob', 'Silver')
      expect(subject.handles?(node)).to be_falsey
    end
  end

  it 'returns a message' do
    node = Merchant::UnknownDefintionOrQuery.new
    message = 'I have no idea what you are talking about'
    expect(subject.process(node)).to eq(message)
  end
end
