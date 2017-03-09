module Merchant
  class GalaticTrade
    def initialize
      g_to_r_service = Merchant::GalaticToRomanService.new
      g_to_a_service = Merchant::GalaticToArabicService.new(g_to_r_service)
      price_definition_service = Merchant::PriceDefinitionService.new(g_to_a_service)
      commodity_price_service = Merchant::CommodityPriceService.new(g_to_a_service,
                                                                    price_definition_service)
      @services = [g_to_r_service, g_to_a_service, price_definition_service, commodity_price_service]
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
