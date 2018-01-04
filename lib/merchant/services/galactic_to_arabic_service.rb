module Merchant
  class GalacticToArabicService
    def initialize(galactic_to_roman_service)
      @roman_to_arabic_converter = RomanToArabicConverter.new
      @galactic_to_roman_service = galactic_to_roman_service
    end

    def convert(galactic)
      roman = @galactic_to_roman_service.translate_numerals(galactic)
      @roman_to_arabic_converter.convert(roman)
    end

    def handles?(node)
      node.is_a?(TranslationQuery)
    end

    def process(node)
      galactic = node.galactic
      arabic = convert(galactic)
      "#{galactic} is #{arabic}"
    end
  end
end
