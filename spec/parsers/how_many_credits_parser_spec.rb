require 'spec_helper'

RSpec.describe Merchant::HowManyCreditsParser do
  context 'when preseted with a how many credits question' do
    examples = [
      ['how many Credits is glob prok Silver ?', ['glob prok', 'Silver']],
      ['how many Credits is glob prok Gold ?', ['glob prok', 'Gold']],
      ['how many Credits is glob prok Iron ?', ['glob prok', 'Iron']]
    ]

    examples.each do |example, expected|
      it "can_parse? returns true for valid example - #{example}" do
        expect(subject.can_parse?(example)).to be_truthy
      end

      it "parse returns the galatic numerals and commodity name for #{example}" do
        expect(subject.parse(example)).to eq(expected)
      end
    end
  end

  context 'when presented with an invalid definition or question' do
    examples = [
      'glob is I',
      'prok is V',
      'pish is X',
      'tegj is L',
      'how much is pish tegj glob glob ?',
      'glob glob Silver is 34 Credits',
      'glob prok Gold is 57800 Credits',
      'pish pish Iron is 3910 Credits'
    ]

    examples.each do |example|
      it "can_parse? returns false for invalid examples - #{example}" do
        expect(subject.can_parse?(example)).to be_falsey
      end
    end
  end
end
