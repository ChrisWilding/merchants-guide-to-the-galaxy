module Merchant
  class RomanToArabicConverter
    MAPPING = {
      'M' => 1000,
      'CM' => 900,
      'D' => 500,
      'CD' => 400,
      'C' => 100,
      'XC' => 90,
      'L' => 50,
      'XL' => 40,
      'X' => 10,
      'IX' => 9,
      'V' => 5,
      'IV' => 4,
      'I' =>  1
    }.freeze

    def initialize
      pairs = 1.upto(3999).collect do |i|
        roman = i_to_roman(i)
        [roman, i]
      end

      @lookup = Hash[pairs]
    end

    def convert(roman)
      arabic = @lookup[roman]
      raise "Can not convert roman numeral #{roman} to arabic" unless arabic
      arabic
    end

    private

    def i_to_roman(i)
      MAPPING.inject('') do |out, (roman, arabic)|
        while i >= arabic
          out << roman
          i -= arabic
        end

        out
      end
    end
  end
end
