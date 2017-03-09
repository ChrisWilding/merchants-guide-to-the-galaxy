module Merchant
  class Commodity
    attr_reader :credits, :name

    def initialize(number, name, credits)
      @credits = credits / number
      @name = name
    end
  end
end
