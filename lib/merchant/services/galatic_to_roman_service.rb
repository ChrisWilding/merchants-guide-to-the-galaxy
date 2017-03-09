module Merchant
  class GalaticToRomanService
    def initialize(mapping)
      @mapping = mapping
    end

    def convert(str)
      galatic_numerals = str.split
      galatic_numerals.map do |galatic_numeral|
        roman_numeral = @mapping[galatic_numeral]
        raise "Invalid galatic numeral #{galatic_numeral}" unless roman_numeral
        roman_numeral
      end.join
    end
  end
end
