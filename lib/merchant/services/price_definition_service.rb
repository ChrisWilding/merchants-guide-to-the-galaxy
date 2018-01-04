module Merchant
  class PriceDefinitionService
    def initialize(galactic_to_arabic_service)
      @galactic_to_arabic_service = galactic_to_arabic_service
      @lookup = {}
    end

    def handles?(node)
      node.is_a?(PriceDefinition)
    end

    def process(node)
      arabic = @galactic_to_arabic_service.convert(node.galactic)
      commodity = Merchant::Commodity.new(arabic, node.commodity, node.credits)
      @lookup[commodity.name] = commodity.credits
      nil
    end

    def price_of(name)
      credits = @lookup[name]
      raise "No price of #{name}" unless credits
      credits
    end
  end
end
