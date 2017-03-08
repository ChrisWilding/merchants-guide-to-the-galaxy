module Merchant
  class GalaticToRomanParser
    REGEX = /^(.*) is (I|V|X|L|C|D|M)$/

    def handles?(str)
      @matches ||= REGEX.match(str)
    end

    def parse(str)
      return @matches[1], @matches[2] if handles?(str)
    end
  end
end
