module Merchant
  class PriceDefinitionParser
    REGEX = /^(.*) is (\d+) Credits$/

    def handles?(str)
      str.end_with?('Credits')
    end

    def parse(str)
      return unless handles?(str)
      matches = REGEX.match(str)
      number_and_commodity = matches[1].split
      number = number_and_commodity[0...-1].join(' ')
      commodity = number_and_commodity[-1]
      credits = matches[2]
      [number, commodity, credits]
    end
  end
end
