module Merchant
  class PriceDefinitionService
    def initialize(galatic_to_arabic_service, parser = Merchant::PriceDefinitionParser.new)
      @galatic_to_arabic_service = galatic_to_arabic_service
      @lookup = {}
      @parser = parser
    end

    def handles?(str)
      @parser.can_parse?(str)
    end

    def process(str)
      galatic_numerals, name, credits = @parser.parse(str)
      number = @galatic_to_arabic_service.convert(galatic_numerals)
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
