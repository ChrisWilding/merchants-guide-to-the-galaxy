module Merchant
  class CommodityConversion
    attr_reader :from_commodity, :to_commodity, :galactic

    def initialize(from_commodity, to_commodity, galactic)
      @from_commodity = from_commodity
      @to_commodity = to_commodity
      @galactic = galactic
    end
  end
end
