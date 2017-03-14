module Merchant
  class GalacticToArabicService
    def initialize(galactic_to_roman_service)
      @converter = RomanToArabicConverter.new
      @galactic_to_roman_service = galactic_to_roman_service
    end

    def convert(numerals)
      translated = @galactic_to_roman_service.translate_numerals(numerals)
      @converter.convert(translated)
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
