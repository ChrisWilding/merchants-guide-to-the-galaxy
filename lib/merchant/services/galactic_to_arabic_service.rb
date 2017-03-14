module Merchant
  class GalacticToArabicService
    def initialize(translator)
      @converter = RomanToArabicConverter.new
      @translator = translator
    end

    def convert(numerals)
      translated = @translator.translate_numerals(numerals)
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
