module Merchant
  class CommodityPriceService
    def initialize(galactic_to_arabic_service,
                   price_definition_service,
                   parser = Merchant::HowManyCreditsParser.new)
      @galactic_to_arabic_service = galactic_to_arabic_service
      @price_definition_service = price_definition_service
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galactic, commodity = @parser.parse(str)
      number = @galactic_to_arabic_service.convert(galactic)
      price = @price_definition_service.price_of(commodity)
      "#{galactic} #{commodity} is #{Integer(price * number)} Credits"
    end
  end
end
