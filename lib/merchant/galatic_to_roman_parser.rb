module Merchant
  class GalaticToRomanParser
    REGEX = /^(.*) is (I|V|X|L|C|D|M)$/

    def handles?(str)
      REGEX.match(str)
    end

    def parse(str)
      matches = REGEX.match(str)
      return matches[1], matches[2] if matches
    end
  end
end
