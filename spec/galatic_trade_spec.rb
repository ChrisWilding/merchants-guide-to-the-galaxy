require 'spec_helper'

RSpec.describe Merchant::GalaticTrade do
  inputs = [
    'glob is I',
    'prok is V',
    'pish is X',
    'tegj is L',
    'glob glob Silver is 34 Credits',
    'glob prok Gold is 57800 Credits',
    'pish pish Iron is 3910 Credits',
    'how much is pish tegj glob glob ?',
    'how many Credits is glob prok Silver ?',
    'how many Credits is glob prok Gold ?',
    'how many Credits is glob prok Iron ?',
    'how much wood could a woodchuck chuck if a woodchuck could chuck wood ?'
  ]

  expected = 'pish tegj glob glob is 42
glob prok Silver is 68 Credits
glob prok Gold is 57800 Credits
glob prok Iron is 782 Credits
I have no idea what you are talking about'

  it 'conducts galatic trade' do
    result = subject.conduct(inputs)
    expect(result).to eq(expected)
  end
end
