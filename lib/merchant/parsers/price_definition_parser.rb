module Merchant
  class PriceDefinitionParser
    REGEX = /^(.*) is (\d+) Credits$/

    def can_parse?(str)
      str.end_with?('Credits')
    end

    def parse(str)
      return unless can_parse?(str)
      matches = REGEX.match(str)
      *numbers, name = matches[1].split
      number = numbers.join(' ')
      credits = matches[2]
      [number, name, credits.to_i]
    end
  end
end
