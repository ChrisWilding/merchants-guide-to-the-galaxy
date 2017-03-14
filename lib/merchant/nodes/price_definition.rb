module Merchant
  class PriceDefinition
    attr_reader :commodity, :credits, :galactic

    def initialize(galactic, commodity, credits)
      @galactic = galactic
      @commodity = commodity
      @credits = credits
    end
  end
end
