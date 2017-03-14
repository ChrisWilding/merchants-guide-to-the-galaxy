module Merchant
  class GalacticTrade
    def initialize
      @galactic_to_roman_service = GalacticToRomanService.new
      @galactic_to_arabic_service = GalacticToArabicService.new(
        @galactic_to_roman_service
      )
      @price_definition_service = PriceDefinitionService.new(
        @galactic_to_arabic_service
      )
      @price_query_service = PriceQueryService.new(
        @galactic_to_arabic_service, @price_definition_service
      )
    end

    def conduct(input)
      ast = Parser.new(input).parse
      ast.each_with_object([]) do |node, out|
        service = services.find { |s| s.handles?(node) }
        result = service.process(node)
        out << result if result
      end.join("\n")
    end

    private

    def services
      @services ||= [
        @galactic_to_roman_service,
        @galactic_to_arabic_service,
        @price_definition_service,
        @price_query_service,
        UnknownDefinitionOrQueryService.new
      ]
    end
  end
end
