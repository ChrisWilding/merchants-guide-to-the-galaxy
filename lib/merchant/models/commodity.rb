module Merchant
  class Commodity
    attr_reader :credits, :name

    def initialize(number, credits, name)
      @credits = credits / number
      @name = name
    end
  end
end
