module Merchant
  class CLI
    def run
      if ARGV.length == 1
        input = File.read(ARGV[0])
        galactic_trade = GalacticTrade.new
        puts galactic_trade.conduct(input)
      else
        puts 'Usage: merchant ./path/to/input.txt'
      end
    end
  end
end
