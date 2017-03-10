module Merchant
  class PriceDefinitionService
    def initialize(galactic_to_arabic_service,
                   parser = PriceDefinitionParser.new)
      @galactic_to_arabic_service = galactic_to_arabic_service
      @lookup = {}
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galactic_numerals, name, credits = @parser.parse(str)
      number = @galactic_to_arabic_service.convert(galactic_numerals)
      commodity = Merchant::Commodity.new(number, name, credits)
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
