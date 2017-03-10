require 'spec_helper'

RSpec.describe Merchant::GalacticToRomanParser do
  context 'when preseted with a valid galactic to roman translation' do
    examples = [
      ['glob is I', %w(glob I)],
      ['prok is V', %w(prok V)],
      ['pish is X', %w(pish X)],
      ['tegj is L', %w(tegj L)]
    ]

    examples.each do |example, expected|
      it "can_parse? returns true for valid example - #{example}" do
        expect(subject.can_parse?(example)).to be_truthy
      end

      it "parse returns the galactic and roman numeral for #{example}" do
        expect(subject.parse(example)).to eq(expected)
      end
    end
  end

  context 'when parse is called twice with different strings' do
    it 'returns different results' do
      result1 = subject.parse('glob is I')
      result2 = subject.parse('prok is V')
      expect(result1).to eq(%w(glob I))
      expect(result2).to eq(%w(prok V))
    end
  end

  context 'when presented with an invalid galactic to roman translation' do
    examples = [
      'glob glob Silver is 34 Credits',
      'glob prok Gold is 57800 Credits',
      'pish pish Iron is 3910 Credits',
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
