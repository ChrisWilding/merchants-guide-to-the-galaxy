module Merchant
  class HowManyCreditsParser
    REGEX = /^how many Credits is (.+)\?$/

    def can_parse?(str)
      REGEX =~ str
    end

    def parse(str)
      matches = REGEX.match(str)
      *numerals, commodity = matches[1].strip.split
      [numerals.join(' '), commodity]
    end
  end
end
