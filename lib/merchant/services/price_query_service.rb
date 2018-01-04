module Merchant
  class PriceQueryService
    def initialize(galactic_to_arabic_service, price_definition_service)
      @galactic_to_arabic_service = galactic_to_arabic_service
      @price_definition_service = price_definition_service
    end

    def handles?(node)
      node.is_a?(PriceQuery)
    end

    def process(node)
      arabic = @galactic_to_arabic_service.convert(node.galactic)
      price = @price_definition_service.price_of(node.commodity)
      "#{node.galactic} #{node.commodity} is #{Integer(arabic * price)} Credits"
    end
  end
end
