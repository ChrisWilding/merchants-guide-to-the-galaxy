module Merchant
  class HowMuchParser
    REGEX = /^how much is (.+)\?$/

    def can_parse?(str)
      REGEX =~ str
    end

    def parse(str)
      matches = REGEX.match(str)
      matches[1].strip
    end
  end
end
