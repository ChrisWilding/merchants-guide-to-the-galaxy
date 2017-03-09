require 'spec_helper'

RSpec.describe Merchant::PriceDefinitionParser do
  context 'when preseted with a valid price definition' do
    examples = [
      ['glob glob Silver is 34 Credits', ['glob glob', 'Silver', '34']],
      ['glob prok Gold is 57800 Credits', ['glob prok', 'Gold', '57800']],
      ['pish pish Iron is 3910 Credits', ['pish pish', 'Iron', '3910']]
    ]

    examples.each do |example, expected|
      it "can_parse? returns true for valid example - #{example}" do
        expect(subject.can_parse?(example)).to be_truthy
      end

      it "parse returns the galatic number, commodity, and credits for #{example}" do
        expect(subject.parse(example)).to eq(expected)
      end
    end
  end

  context 'when presented with an invalid galatic to roman translation' do
    examples = [
      'glob is I',
      'prok is V',
      'pish is X',
      'tegj is L',
      'how much is pish tegj glob glob ?',
      'how many Credits is glob prok Silver ?',
      'how many Credits is glob prok Gold ?',
      'how many Credits is glob prok Iron ?',
      'how much wood could a woodchuck chuck if a woodchuck could chuck wood ?'
    ]

    examples.each do |example|
      it "can_parse? returns false for invalid examples - #{example}" do
        expect(subject.can_parse?(example)).to be_falsey
      end
    end
  end
end
