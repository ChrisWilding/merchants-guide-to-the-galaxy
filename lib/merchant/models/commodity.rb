require 'bigdecimal'

module Merchant
  class Commodity
    attr_reader :credits, :name

    def initialize(number, name, credits)
      @credits = BigDecimal.new(credits) / BigDecimal.new(number)
      @name = name
    end
  end
end
