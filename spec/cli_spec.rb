require 'spec_helper'

RSpec.describe Merchant::CLI do
  expected = 'pish tegj glob glob is 42
glob prok Silver is 68 Credits
glob prok Gold is 57800 Credits
glob prok Iron is 782 Credits
I have no idea what you are talking about'

  it 'loads the file and conducts the galactic trade' do
    ARGV.replace(["#{File.dirname(__FILE__)}/../fixtures/input.txt"])
    expect(STDOUT).to receive(:puts).with(expected)
    subject.run
  end
end
