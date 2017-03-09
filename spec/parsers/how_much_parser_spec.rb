require 'spec_helper'

RSpec.describe Merchant::HowMuchParser do
  context 'when preseted with a how much question' do
    let(:example) { 'how much is pish tegj glob glob ?' }

    it 'can_parse? returns true for valid example' do
      expect(subject.can_parse?(example)).to be_truthy
    end

    it 'parse returns the galatic numeral part of the question' do
      expect(subject.parse(example)).to eq('pish tegj glob glob')
    end
  end

  context 'when presented with an invalid definition or question' do
    examples = [
      'glob is I',
      'prok is V',
      'pish is X',
      'tegj is L',
      'glob glob Silver is 34 Credits',
      'glob prok Gold is 57800 Credits',
      'pish pish Iron is 3910 Credits',
      'how many Credits is glob prok Silver ?',
      'how many Credits is glob prok Gold ?',
      'how many Credits is glob prok Iron ?'
    ]

    examples.each do |example|
      it "can_parse? returns false for invalid examples - #{example}" do
        expect(subject.can_parse?(example)).to be_falsey
      end
    end
  end
end
