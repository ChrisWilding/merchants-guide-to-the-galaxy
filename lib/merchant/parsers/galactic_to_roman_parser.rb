module Merchant
  class GalacticToRomanParser
    REGEX = /^(.*) is (I|V|X|L|C|D|M)$/

    def can_parse?(str)
      REGEX =~ str
    end

    def parse(str)
      REGEX.match(str)[1, 2]
    end
  end
end
