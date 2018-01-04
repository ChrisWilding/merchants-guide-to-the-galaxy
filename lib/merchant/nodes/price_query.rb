module Merchant
  class PriceQuery
    attr_reader :commodity, :galactic

    def initialize(galactic, commodity)
      @galactic = galactic
      @commodity = commodity
    end
  end
end
