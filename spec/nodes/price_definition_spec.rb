require 'spec_helper'

module Merchant
  class PriceDefinition
    attr_reader :commodity, :credits, :galactic

    def initialize(galactic, commodity, credits)
      @galactic = galactic
      @commodity = commodity
      @credits = credits
    end
  end
end

RSpec.describe Merchant::PriceDefinition do
  subject do
    described_class.new('glob glob', 'Silver', '34')
  end

  it 'has a commodity property' do
    expect(subject.commodity).to eq('Silver')
  end

  it 'has a credits property' do
    expect(subject.credits).to eq('34')
  end

  it 'has a galactic property' do
    expect(subject.galactic).to eq('glob glob')
  end
end
