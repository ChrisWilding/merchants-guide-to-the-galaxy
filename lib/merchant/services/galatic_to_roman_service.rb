module Merchant
  class GalaticToRomanService
    def initialize(mapping = {}, parser = Merchant::GalaticToRomanParser.new)
      @mapping = mapping
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galatic, roman = @parser.parse(str)
      @mapping[galatic] = roman
      nil
    end

    def translate_numeral(str)
      roman = @mapping[str]
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
