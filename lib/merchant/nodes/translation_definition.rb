module Merchant
  class TranslationDefinition
    attr_reader :galactic, :roman

    def initialize(galactic, roman)
      @galactic = galactic
      @roman = roman
    end
  end
end
