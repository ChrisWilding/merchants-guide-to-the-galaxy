module Merchant
  class GalaticToArabicService
    def initialize(translator)
      @converter = RomanToArabicConverter.new
      @translator = translator
    end

    def convert(numeral)
      translated = @translator.translate_numerals(numeral)
      @converter.convert(translated)
    end
  end
end
