require 'spec_helper'

RSpec.describe Merchant do
  it 'has a version number' do
    expect(Merchant::VERSION).not_to be nil
  end
end
