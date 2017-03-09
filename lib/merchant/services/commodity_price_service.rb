module Merchant
  class CommodityPriceService
    def initialize(galatic_to_arabic_service,
                   price_definition_service,
                   parser = Merchant::HowManyCreditsParser.new)
      @galatic_to_arabic_service = galatic_to_arabic_service
      @price_definition_service = price_definition_service
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galatic, commodity = @parser.parse(str)
      number = @galatic_to_arabic_service.convert(galatic)
      price = @price_definition_service.price_of(commodity)
      "#{galatic} #{commodity} is #{price * number} Credits"
    end
  end
end
