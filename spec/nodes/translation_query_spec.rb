require 'spec_helper'

RSpec.describe Merchant::TranslationQuery do
  let(:galactic) { 'prok' }

  subject do
    described_class.new(galactic)
  end

  it 'has a galactic property' do
    expect(subject.galactic).to eq(galactic)
  end
end
