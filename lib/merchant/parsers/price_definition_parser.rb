module Merchant
  class PriceDefinitionParser
    REGEX = /^(.*) is (\d+) Credits$/

    def handles?(str)
      str.end_with?('Credits')
    end

    def parse(str)
      return unless handles?(str)
      matches = REGEX.match(str)
      *numbers, commodity = matches[1].split
      number = numbers.join(' ')
      credits = matches[2]
      [number, commodity, credits]
    end
  end
end
