module Merchant
  class CLI
    def run
      if ARGV.length == 1
        lines = File.readlines(ARGV[0]).collect(&:strip)
        galactic_trade = GalacticTrade.new
        puts galactic_trade.conduct(lines)
      else
        puts 'Usage: merchant ./path/to/input.txt'
      end
    end
  end
end
