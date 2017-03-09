module Merchant
  class GalaticToRomanService
    def initialize(parser = Merchant::GalaticToRomanParser.new)
      @lookup = {}
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galatic, roman = @parser.parse(str)
      @lookup[galatic] = roman
      nil
    end

    def translate_numeral(str)
      roman = @lookup[str]
      raise "Can not translate invalid numeral #{str}" unless roman
      roman
    end

    def translate_numerals(str)
      str.split.collect do |numeral|
        translate_numeral(numeral)
      end.join
    end
  end
end
