module Merchant
  class GalacticToRomanService
    def initialize
      @lookup = {}
    end

    def handles?(node)
      node.is_a?(TranslationDefinition)
    end

    def process(node)
      @lookup[node.galactic] = node.roman
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
