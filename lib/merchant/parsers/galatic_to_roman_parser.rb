module Merchant
  class GalaticToRomanParser
    REGEX = /^(.*) is (I|V|X|L|C|D|M)$/

    def can_parse?(str)
      @matches ||= REGEX.match(str)
    end

    def parse(str)
      @matches[1, 2] if can_parse?(str)
    end
  end
end
