module Merchant
  class GalaticTrade
    def initialize
      galatic_to_roman_service = Merchant::GalaticToRomanService.new
      galatic_to_arabic_service = Merchant::GalaticToArabicService.new(galatic_to_roman_service)
      price_definition_service = Merchant::PriceDefinitionService.new(galatic_to_arabic_service)
      commodity_price_service = Merchant::CommodityPriceService.new(galatic_to_arabic_service,
                                                                    price_definition_service)
      @services = [
        galatic_to_roman_service,
        galatic_to_arabic_service,
        price_definition_service,
        commodity_price_service
      ]
    end

    def conduct(inputs)
      inputs.each_with_object([]) do |input, out|
        service = @services.find { |s| s.handles?(input) }
        begin
          result = service.process(input)
          out << result if result
        rescue
          out << 'I have no idea what you are talking about'
        end
      end.join("\n")
    end
  end
end
