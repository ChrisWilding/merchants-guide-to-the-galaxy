module Merchant
  class GalaticToArabicService
    def initialize(translator, parser = HowMuchParser.new)
      @converter = RomanToArabicConverter.new
      @parser = parser
      @translator = translator
    end

    def convert(numerals)
      translated = @translator.translate_numerals(numerals)
      @converter.convert(translated)
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      numerals = @parser.parse(str)
      converted = convert(numerals)
      "pish tegj glob glob is #{converted}"
    end
  end
end
